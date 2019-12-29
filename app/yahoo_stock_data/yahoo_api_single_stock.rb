#!/usr/bin/ruby

require 'uri'
require 'net/http'

class YahooStockFetcher
  def fetch(ticker)
    
    uri = URI(build_uri(ticker))
    Net::HTTP.get(uri)
  end
  
  private

  def build_uri(ticker)
    uri_string = ""
    uri_string += "https://query1.finance.yahoo.com/v10/finance/quoteSummary/"
    uri_string += "#{ticker}"
    uri_string += "?modules=#{modules_list.join('%2C')}"
  end

  def modules_list
    return [
        'assetProfile',        	
        'incomeStatementHistory',	
        'incomeStatementHistoryQuarterly',
        'balanceSheetHistory',
        'balanceSheetHistoryQuarterly',
        'cashflowStatementHistory',
        'cashflowStatementHistoryQuarterly',
        'defaultKeyStatistics',
        'financialData',
        'calendarEvents',
        'secFilings',
        'recommendationTrend',
        'upgradeDowngradeHistory',
        'institutionOwnership',
        'fundOwnership',
        'majorDirectHolders',
        'majorHoldersBreakdown',
        'insiderTransactions',
        'insiderHolders',
        'netSharePurchaseActivity',
        'earnings',
        'earningsHistory',
        'earningsTrend',
        'industryTrend',
        'indexTrend',
        'sectorTrend']
  end
end

fetcher = YahooStockFetcher.new
puts fetcher.fetch('AAPL')
