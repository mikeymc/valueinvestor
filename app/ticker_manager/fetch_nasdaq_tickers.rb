#!/usr/bin/ruby

require 'csv'
require 'net/ftp'

class NasdaqTickerFetcher
  def fetch
    ftp = Net::FTP.new
    ftp.connect('ftp.nasdaqtrader.com')
    ftp.login
    ftp.chdir('SymbolDirectory')
    ftp.gettextfile('nasdaqlisted.txt')
    ftp.gettextfile('otherlisted.txt')
  end
end

fetcher = NasdaqTickerFetcher.new
fetcher.fetch
