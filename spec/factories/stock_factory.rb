FactoryGirl.define do
  factory :stock do
    name 'Apple Computer'
    symbol 'AAPL'
    exchange 'Nasdaq'
    # current_eps = 1.2
    # dividends_per_share 2.3
    # day_high_price 100.1
    # day_low_price 99.1
    # book_value 1234.56
    # price_to_book_ratio 2.1
    # price_to_earnings_ratio 4.3
    # year_low_price 21.4
    # year_high_price 200.1
    #
    market_watch_data
  end

  factory :market_watch_data do
    average_recommendation 'Buy'
  end
end
