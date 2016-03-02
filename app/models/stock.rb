class Stock < ActiveRecord::Base
  has_one :yahoo_data, dependent: :destroy
  has_one :market_watch_data, dependent: :destroy
  has_one :street_insider_data, dependent: :destroy
  has_one :bar_chart_data, dependent: :destroy
  has_one :yahoo_key_statistics_data, dependent: :destroy

  scope :yield_above, -> (amount) { where("yahoo_data.dividend_yield >= #{amount}") }
  scope :price_to_earnings_below, -> (amount) { where("yahoo_data.price_to_earnings_ratio <= #{amount}") }
  scope :profit_margin_at_least, -> (amount) { where("yahoo_key_statistics_data.profit_margin >= #{amount}") }
  scope :operating_margin_at_least, -> (amount) { where("yahoo_key_statistics_data.operating_margin >= #{amount}") }

  def self.list_all_symbols
    symbols = []
    Stock.all.each do |stock|
      symbols << stock.symbol
    end
    symbols
  end

  def self.sanitize_field(field)
    (field.eql?('N/A') || field.eql?('nan')) ? '' : field
  end

  def google_finance_link
    "https://www.google.com/finance?q=#{self.symbol}"
  end

  def market_watch_recommendation
    if self.market_watch_data
      market_watch_data.average_recommendation
    end
  end

  def street_insider_recommendation
    if self.street_insider_data
      street_insider_data.average_recommendation
    end
  end

  def bar_chart_recommendation
    if self.bar_chart_data
      bar_chart_data.average_recommendation
    end
  end

  def ebitda_to_ev
    if self.yahoo_data &&
      self.yahoo_data.ebitda &&
      self.yahoo_key_statistics_data &&
      self.yahoo_key_statistics_data.enterprise_value
      yahoo_data.ebitda / yahoo_key_statistics_data.enterprise_value
    end
  end
end
