#!/usr/bin/ruby

class OtherSecuritiesParser
  def parse
    ###
    #  ACT Symbol|Security Name|Exchange|CQS Symbol|ETF|Round Lot Size|Test Issue|NASDAQ Symbol
    #
    #  ACT Symbol:
    #    Identifier for each security used in ACT and CTCI connectivity protocol.
    #    Typical identifiers have 1-5 character root symbol and then 1-3 characters for suffixes.
    #    Allow up to 14 characters.
    #  Security Name:
    #    The name of the security including additional information, if applicable.
    #    Examples are security type (common stock, preferred stock, etc.) or class (class A or B, etc.).
    #    Allow up to 255 characters.
    #  Exchange: The listing stock exchange or market of a security.
    #    - Values:
    #      * A = NYSE MKT
    #      * N = New York Stock Exchange (NYSE)
    #      * P = NYSE ARCA
    #      * Z = BATS Global Markets (BATS)
    #      * V = Investors' Exchange, LLC (IEXG)
    #  CQS Symbol:
    #    Identifier of the security used to disseminate data via:
    #      SIAC Consolidated Quotation System (CQS)
    #      Consolidated Tape System (CTS) data feeds.
    #    Typical identifiers have 1-5 character root symbol and then 1-3 characters for suffixes.
    #    Allow up to 14 characters.
    #  ETF: Identifies whether the security is an exchange traded fund (ETF).
    #    Possible values:
    #      * Y = Yes, security is an ETF
    #      * N = No, security is not an ETF
    #    For new ETFs added to the file, the ETF field for the record will be updated to a value of "Y".
    #  Round Lot: Indicates the number of shares that make up a round lot for the given security.
    #  Test Issue: Indicates whether or not the security is a test security.
    #    - Values:
    #        * Y = yes, it is a test issue.
    #        * N = no, it is not a test issue.
    #  NASDAQ Symbol: Identifier of the security used to in
    #    Various NASDAQ connectivity protocols and
    #    NASDAQ market data feeds.
    #    Typical identifiers have 1-5 character root symbol and then 1-3 characters for suffixes.
    #    Allow up to 14 characters.
    #  File Creation Time: When NASDAQ Trader generated the file.
    #    - The row contains the words File Creation Time followed by mmddyyyyhhmm as the first field.
    #    - Example: File Creation Time: 1217200717:03|||||
    ###

    list = File.readlines('otherlisted.txt', chomp: true)[1..-2]
    list = list.map! do |line|
      items = line.split('|')
      {
        symbol: items[0],
        name: items[1],
        exchange: items[2],
        cqs_symbol: items[3],
        etf: items[4],
        round_lot: items[5],
        test_issue: items[6],
        nasdaq_symbol: items[7]
      }
    end
    
    return list.select! {|item| item[:test_issue] == 'N' && item[:exchange] == 'N'}
  end
end
