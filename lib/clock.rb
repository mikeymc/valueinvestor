require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(24.hours, 'Running my daily process...') do
  puts 'aggregating stocks...'
  StockDataAggregator.new.aggregate
end

every(8.hours, 'Running my thrice-daily process...') do
  puts 'aggregating yahoo key stats...'
  YahooKeyStatisticsDataAggregator.new.aggregate
  puts 'aggregating mw data...'
  MarketWatchDataAggregator.new.aggregate
  puts 'aggregating bar chart data...'
  BarChartDataAggregator.new.aggregate
  puts 'aggregating street insider data...'
  StreetInsiderDataAggregator.new.aggregate
  puts 'done!'
end
