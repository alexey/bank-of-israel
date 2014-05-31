require 'spec_helper'

describe BankOfIsrael do

  let(:exchange_rates) {{:release_date => "2014-05-30",
                         :usd=>{:name=>"Dollar", :unit=>"1", :country=>"USA", :rate=>"3.475", :change=>"-0.029"},
                         :gbp=>{:name=>"Pound", :unit=>"1", :country=>"Great Britain", :rate=>"5.8158", :change=>"0.11"},
                         :jpy=>{:name=>"Yen", :unit=>"100", :country=>"Japan", :rate=>"3.4188", :change=>"-0.114"},
                         :eur=>{:name=>"Euro", :unit=>"1", :country=>"EMU", :rate=>"4.7283", :change=>"-0.106"},
                         :aud=>{:name=>"Dollar", :unit=>"1", :country=>"Australia", :rate=>"3.2369", :change=>"0.198"},
                         :cad=>{:name=>"Dollar", :unit=>"1", :country=>"Canada", :rate=>"3.2083", :change=>"0.25"},
                         :dkk=>{:name=>"krone", :unit=>"1", :country=>"Denmark", :rate=>"0.6335", :change=>"-0.079"},
                         :nok=>{:name=>"Krone", :unit=>"1", :country=>"Norway", :rate=>"0.5822", :change=>"-0.257"},
                         :zar=>{:name=>"Rand", :unit=>"1", :country=>"South Africa", :rate=>"0.3327", :change=>"-0.12"},
                         :sek=>{:name=>"Krona", :unit=>"1", :country=>"Sweden", :rate=>"0.5210", :change=>"-0.648"},
                         :chf=>{:name=>"Franc", :unit=>"1", :country=>"Switzerland", :rate=>"3.8735", :change=>"-0.067"},
                         :jod=>{:name=>"Dinar", :unit=>"1", :country=>"Jordan", :rate=>"4.9046", :change=>"-0.041"},
                         :lbp=>{:name=>"Pound", :unit=>"10", :country=>"Lebanon", :rate=>"0.0230", :change=>"0"},
                         :egp=>{:name=>"Pound", :unit=>"1", :country=>"Egypt", :rate=>"0.4860", :change=>"-0.041"}}  }

  context ".rates" do

    it "returns formatted exchange rates", :vcr do
      expect(BankOfIsrael.rates("20140530")).to eq exchange_rates
    end

    it "raises an exception on Sundays" do
      expect { BankOfIsrael.rates("20140504") }.to raise_error(RuntimeError, "rates not available on sunday and saturday")
    end

    it "raises an exception on Saturdays" do
      expect { BankOfIsrael.rates("20140531") }.to raise_error(RuntimeError, "rates not available on sunday and saturday")
    end

    context "given that the input date rates are not published" do
      it "raises an exception", :vcr do
        expect { BankOfIsrael.rates("20140506") }.to raise_error(RuntimeError, "rates not available on the given date")
      end
    end

  end

  context ".latest_rates" do
    context "given that today's rates are not published" do

      # lets say today is the 31th, may 2014
      it "returns yesterday's rates", :vcr do
        expect(BankOfIsrael.latest_rates[:release_date]).to eq ("2014-05-30")
      end
    end
  end
end
