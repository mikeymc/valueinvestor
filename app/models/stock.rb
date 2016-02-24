class Stock < ActiveRecord::Base
  has_one :market_watch_data, dependent: :destroy

  def self.list_all_symbols
    symbols = []
    Stock.all.each do |stock|
      symbols << stock.symbol
    end
    symbols
  end

  def self.create_new_stock(stock)
    if (stock[:name] != 'N/A')
      s = Stock.new
      s.name = sanitize_field stock[:name]
      s.symbol = sanitize_field stock[:symbol]
      s.exchange = sanitize_field stock[:exchange]
      s.current_eps = sanitize_field stock[:current_eps]
      s.dividends_per_share = sanitize_field stock[:dividends_per_share]
      s.day_high_price = sanitize_field stock[:day_high_price]
      s.day_low_price = sanitize_field stock[:day_low_price]
      s.book_value = sanitize_field stock[:book_value]
      s.price_to_book_ratio = sanitize_field stock[:price_to_book_ratio]
      s.save!
    end
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
end
