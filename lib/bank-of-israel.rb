require "multi_xml"
require 'uri'
require 'net/http'

class BankOfIsrael

  def self.rates(date)
    raise "Please provide a date in YYYYMMDD format" unless date
    call_bank(params(date))
  end

  def self.latest_rates
    call_bank
  end

  private

  def self.params(date)
    { "rdate" => format_date(date) }
  end

  def self.format_date(date)
    begin
      date = DateTime.parse(date.to_s)
      raise "rates not available on sunday and saturday" if date.sunday? or date.saturday?
      date.strftime("%Y%m%d")
    rescue ArgumentError
      raise "Please provide a date in YYYYMMDD format"
    end
  end

  def self.call_bank(params = {})
    MultiXml.parser = :nokogiri
    uri = URI.parse("http://www.bankisrael.gov.il")
    http = Net::HTTP.new(uri.host, uri.port)
    full_path = encode_path_params("/currency.xml", params)
    request = Net::HTTP::Get.new(full_path)

    response = http.request(request)
    hash = MultiXml.parse(response.body)
    parse(hash)
  end

  def self.encode_path_params(path, params)
    encoded = URI.encode_www_form(params)
    [path, encoded].join("?")
  end

  def self.parse(hash)
    raise "rates not available on the given date" if hash["CURRENCIES"]["ERROR1"] == "Requested date is invalid or"
    helper_hash = { :release_date => hash["CURRENCIES"]["LAST_UPDATE"] }
    hash["CURRENCIES"]["CURRENCY"].each do |c|
      helper_hash.merge! c["CURRENCYCODE"] => c.reject {|k,v| k == "CURRENCYCODE"}
    end

    downcase_and_symbolize(helper_hash)
  end

  def self.downcase_and_symbolize(obj)
    return obj.inject({}){|memo,(k,v)| memo[k.downcase.to_sym] =  downcase_and_symbolize(v); memo} if obj.is_a? Hash
    return obj.inject([]){|memo,v    | memo                    << downcase_and_symbolize(v); memo} if obj.is_a? Array
    return obj
  end
end
