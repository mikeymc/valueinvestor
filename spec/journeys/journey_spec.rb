require 'rails_helper'

RSpec.describe 'finding stocks' do
  it 'enables the user to view stocks' do
    visit '/'
    expect(page).to have_content 'Global Stocks'
    see_headers
  end

  def see_headers
    expected_row_headers = [
      'Name',
      'Exchange',
      'EPS',
      'Dividends/Share',
      'Day High',
      'Day Low',
      'Book Value',
      'Price/Book',
      'P/E',
      'Year Low',
      'Year High'
    ]
    actual_row_headers = page.all('.all-stocks-table th').map do |header|
      header.text
    end
    expected_row_headers.each do |expected_header|
      expect(actual_row_headers).to include expected_header
    end
  end
end
