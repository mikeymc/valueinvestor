require 'CSV'

class ListInitializer
  def initialize_nasdaq_list
    csv_rows = CSV.read('db/nasdaq.csv')
    csv_rows.shift
    csv_rows.map do |row|
      Stock.create!(symbol: row[0].strip, name: row[1].strip, index: 'Nasdaq')
    end
  end

  def initialize_nyse_list
    csv_rows = CSV.read('db/nyse.csv')
    csv_rows.shift
    csv_rows.map do |row|
      Stock.create!(symbol: row[0].strip, name: row[1].strip, index: 'NYSE')
    end
  end
end
