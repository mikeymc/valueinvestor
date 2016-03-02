FactoryGirl.define do
  factory :yahoo_data do
    current_eps 3.4
    book_value 2.1
    dividend_yield 1.1
  end

  factory :yahoo_key_statistics_data do
    profit_margin 3.4
  end

  factory :stock do
    name 'Apple Computer'
    symbol 'AAPL'
    exchange 'Nasdaq'
    yahoo_data
  end

  factory :market_watch_data do
    average_recommendation 'Buy'
  end
end
