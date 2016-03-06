require 'csv'

class ListInitializer
  def refresh_nasdaq_stock_list
    WebMock.allow_net_connect!
    data = Net::HTTP.get('www.nasdaq.com', '/screening/companies-by-name.aspx?letter=0&exchange=nasdaq&render=download')
    nasdaq_file = File.new('db/nasdaq.csv', 'w')
    nasdaq_file.write(data)
  end

  def refresh_nyse_stock_list
    WebMock.allow_net_connect!
    data = Net::HTTP.get('www.nasdaq.com', '/screening/companies-by-name.aspx?letter=0&exchange=nyse&render=download')
    nyse_file = File.new('db/nyse.csv', 'w')
    nyse_file.write(data)
  end

  def load_nasdaq_list
    csv_rows = CSV.read('db/nasdaq.csv')
    csv_rows.shift
    csv_rows.map do |row|
      Stock.create!(symbol: row[0].strip, name: row[1].strip.upcase, exchange: 'Nasdaq')
    end
  end

  def load_nyse_list
    csv_rows = CSV.read('db/nyse.csv')
    csv_rows.shift
    csv_rows.map do |row|
      Stock.create!(symbol: row[0].strip, name: row[1].strip.upcase, exchange: 'NYSE')
    end
  end
end
