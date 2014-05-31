bank-of-israel
==============

A simple client for the Bank of Israel Exchange Rates information

## Installation

    gem install bank-of-israel

## Source and development

The source for bank-of-israel is available on [Github](https://github.com/danevron/bank-of-israel)

The Gem uses rspec and webmock for testing, do a `bundle install` for all
the development requirements.

## Usage

	require 'bank-of-israel'
	
The Gem exposes two methods:

1. BankOfIsrael.rates("YYYYMMDD") - to return the exchange rates for a given date 

		BankOfIsrael.rates("20140530")
		
2. BankOfIsrael.latest_rates - to return the latest available rates

		BankOfIsrael.latest_rates

### Respense hash example

	{:release_date => "2014-05-30",
	 :usd=>{:name=>"Dollar", :unit=>"1", :country=>"USA", :rate=>"3.475", :change=>"-0.029"},
	 :gbp=>{:name=>"Pound", :unit=>"1", :country=>"Great Britain", :rate=>"5.8158", :change=>"0.11"},
	 :jpy=>{:name=>"Yen", :unit=>"100", :country=>"Japan", :rate=>"3.4188", :change=>"-0.114"}}
	 
You can find detailed information about the fields [here](http://www.boi.org.il/en/Markets/Pages/explainxml.aspx).

