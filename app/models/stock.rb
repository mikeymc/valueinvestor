class Stock < ActiveRecord::Base
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
      s.index = sanitize_field stock[:index]
      s.currentEPS = sanitize_field stock[:currentEPS]
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
end
