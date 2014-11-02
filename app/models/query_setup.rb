class QuerySetup

  attr_accessor :list

  def generate_list
    csv = File.read('db/american_stocks.csv')
    if !csv.valid_encoding?
      csv = csv.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
    end
    company_list = csv.split('|||')

    @list = []
    company_list.each do |company|
      @list << company.split(',')[0]
    end
  end

  def get_next_200
    @list.shift(200)
  end

  def self.parse_raw_response_to_json(raw_response)
    list = []
    raw_response_array = raw_response.delete("\"").split("\r\n")
    raw_response_array.each do |stock_obj|
      stock_obj = stock_obj.split(/,(?![\s,])/)
      stock_hash = {
        name: stock_obj[0],
        symbol: stock_obj[1],
        index: stock_obj[2],
        currentEPS: stock_obj[3],
        dividends_per_share: stock_obj[4],
        day_high_price: stock_obj[5],
        day_low_price: stock_obj[6]
      }

      list << stock_hash
    end
    list
  end

  def make_request(stock_list)
    stocks_for_uri = '' + stock_list.shift
    stock_list.each { |symbol| stocks_for_uri = stocks_for_uri + '+' + stock_list.shift }
    WebMock.allow_net_connect!
    url = URI.parse('http://download.finance.yahoo.com/d/quotes.csv?s=' + stocks_for_uri + '&f=nsxe7dgh')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    res
  end
end
