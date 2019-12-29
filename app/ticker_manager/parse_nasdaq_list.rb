#!/usr/bin/ruby

require 'byebug'

class NasdaqTickerListParser
  def parse
=begin
      Symbol|Security Name|Market Category|Test Issue|Financial Status|Round Lot Size|ETF|NextShares

      Symbol: The one to four or five character identifier for each NASDAQ-listed security.
      Security Name: Company issuing the security.
      Market Category: The category assigned to the issue by NASDAQ based on Listing Requirements.
        - Values:
            * Q = NASDAQ Global Select MarketSM
            * G = NASDAQ Global MarketSM
            * S = NASDAQ Capital Market
      Test Issue: Indicates whether or not the security is a test security. 
        - Values: 
            * Y = yes, it is a test issue. 
            * N = no, it is not a test issue.
      Financial Status: Indicates when an issuer has
        - failed to submit its regulatory filings on a timely basis, 
        - failed to meet NASDAQ's continuing listing standards, and/or 
        - filed for bankruptcy.
        - Values:
            * D = Deficient: Issuer Failed to Meet NASDAQ Continued Listing Requirements
            * E = Delinquent: Issuer Missed Regulatory Filing Deadline
            * Q = Bankrupt: Issuer Has Filed for Bankruptcy
            * G = Deficient and Bankrupt
            * H = Deficient and Delinquent
            * J = Delinquent and Bankrupt
            * K = Deficient, Delinquent, and Bankrupt
            * N = Normal (Default): Issuer Is NOT Deficient, Delinquent, or Bankrupt
      Round Lot: Indicates the number of shares that make up a round lot for the given security.
      File Creation Time: When NASDAQ Trader generated the file. 
        - The row contains the words File Creation Time followed by mmddyyyyhhmm as the first field.
        - Example: File Creation Time: 1217200717:03||||| 
=end

    list = File.readlines('nasdaqlisted.txt', chomp: true)[1..-2]
    list = list.map! do |line|
      items = line.split('|')
      {
        symbol: items[0],
        name: items[1],
        market_category: items[2],
        test_issue: items[3],
        financial_status: items[4],
        round_lot: items[5]
      }
    end
    
    return list.reject! {|item| item[:test_issue] == 'Y' || item[:financial_status] !='N' }
  end
end

# NasdaqTickerListParser.new.parse
