require 'net/http'

class StocksController < ApplicationController
  def index
    #Stock.delete_all
    if Stock.all.size == 0 # right now, just caching the results i got on Nov 2 for testing
      @qs = QuerySetup.new
      @qs.generate_list
      ((@qs.list.size/200.0).ceil).times do |i|
        result_list = QuerySetup.parse_raw_response_to_json(@qs.make_request(@qs.get_next_200).body)
        result_list.each do |stock|
          s = Stock.new
          s.name = stock[:name]
          s.symbol = stock[:symbol]
          s.index = stock[:index]
          s.currentEPS = stock[:currentEPS]
          s.dividends_per_share = stock[:dividends_per_share]
          s.day_high_price = stock[:day_high_price]
          s.day_low_price = stock[:day_low_price]
          s.save!
        end
      end
    end
    @stocks = Stock.all
  end
end
