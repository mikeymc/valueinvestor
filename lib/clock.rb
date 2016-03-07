require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.hour, 'Refresh numbers') do
  puts 'Aggregating yahoo data...'
  YahooDataAggregator.new.aggregate
  puts 'Aggregating yahoo key stats...'
  YahooKeyStatisticsDataAggregator.new.aggregate
end

every(1.day, 'Refresh analyses', :at => '02:30') do
  puts 'Aggregating MarketWatch data...'
  MarketWatchDataAggregator.new.aggregate
  puts 'Aggregating BarChart data...'
  BarChartDataAggregator.new.aggregate
  puts 'Aggregating Street Insider data...'
  StreetInsiderDataAggregator.new.aggregate
  puts 'REFRESH COMPLETE!'
end
