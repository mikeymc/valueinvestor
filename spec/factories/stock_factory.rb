FactoryGirl.define do
  factory :stock do
    name 'Apple Computer'
    symbol 'AAPL'
    exchange 'Nasdaq'
  end

  factory :market_watch_data do
    average_recommendation 'Buy'
  end
end
