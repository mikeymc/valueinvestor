require 'rails_helper'

RSpec.describe StockDataAggregator do
  it 'deletes the stocks db' do
    expect(Stock).to receive(:delete_all)

    aggregator = StockDataAggregator.new
    aggregator.aggregate
  end

  it 'reconstructs the Nasdaq and NYSE stock lists' do
    expect_any_instance_of(ListInitializer).to receive(:initialize_nyse_list)
    expect_any_instance_of(ListInitializer).to receive(:initialize_nasdaq_list)

    aggregator = StockDataAggregator.new
    aggregator.aggregate
  end

  it 'fetches the yahoo data for all the stocks' do
    expect_any_instance_of(YahooStockDataFetcher).to receive(:fetch_stock_data).exactly(32).times.and_call_original

    aggregator = StockDataAggregator.new
    aggregator.aggregate
  end

  it 'merges the yahoo data in' do
    aggregator = StockDataAggregator.new
    aggregator.aggregate

    expect(Stock.find_by_symbol('AAPL').book_value).not_to be_nil
  end
end
