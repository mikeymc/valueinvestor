require 'rails_helper'

RSpec.describe 'finding stocks' do
  before(:each) do
    Rails.application.load_seed
  end

  it 'enables the user to view stocks' do
    visit '/'
    see_headers
    see_3M_stock
    sort_by_stock_name
  end

  def sort_by_stock_name
    click_on 'Name'
    stock = page.find('.some-stock', text: 'ZYNGA')
    expect(stock.find('.stock-name')).to have_content 'ZYNGA'
  end

  def see_3M_stock
    stock = page.find('.some-stock', text: '3M COMPANY')
    expect(stock.find('.stock-name')).to have_content '3M COMPANY (MMM) NYSE'
    expect(stock.find('.last-trade-price').text).to match /\d+\.\d+/
    expect(stock.find('.current-eps').text).to match /\d+\.\d+/
    expect(stock.find('.book-value').text).to match /\d+\.\d+/
    expect(stock.find('.price-to-book-ratio').text).to match /\d+\.\d+/
    expect(stock.find('.price-to-earnings-ratio').text).to match /\d+\.\d+/
    expect(stock.find('.year-low-price').text).to match /\d+\.\d+/
    expect(stock.find('.year-high-price').text).to match /\d+\.\d+/
    expect(stock.find('.ebitda').text).to match /\d+\.\d+/
    expect(stock.find('.market-cap').text).to match /\d+\.\d+/
    expect(stock.find('.one-year-target-price').text).to match /\d+\.\d+/
    expect(stock.find('.dividend-yield').text).to match /\d+\.\d+/
    expect(stock.find('.fifty-day-moving-average').text).to match /\d+\.\d+/
    expect(stock.find('.percent-change-from-fifty-day-moving-average').text).to match /\d+\.\d+/
    expect(stock.find('.two-hundred-day-moving-average').text).to match /\d+\.\d+/
    expect(stock.find('.percent-change-from-two-hundred-day-moving-average').text).to match /\d+\.\d+/
    expect(stock.find('.marketwatch-recommendation').text).to match /\D+/
    expect(stock.find('.street-insider-recommendation').text).to match /\D+/
  end

  def see_headers
    expected_row_headers = [
      'Name',
      'Market Cap',
      'EV',
      'EBITDA (ttm)',
      'EBITDA to EV',
      'Last Trade Price',
      'Book Value',
      'P/B (mrq)',
      'P/E',
      'Dividend Yield (%)',
      'Annual EPS',
      'Profit Margin',
      'Operating Margin',
      'Year Low',
      'Year High',
      '1Y Target',
      '1Y Target Growth (%)',
      '50-day Moving Average',
      '% Change from 50-day Moving Average',
      '200-day Moving Average',
      '% Change from 200-day Moving Average',
      'MW',
      'Street Insider',
      'Bar Chart'
    ]
    actual_row_headers = page.all('.all-stocks-table th').map do |header|
      header.text
    end

    expect(actual_row_headers.size).to eq(expected_row_headers.size)

    expected_row_headers.each do |expected_header|
      expect(actual_row_headers).to include expected_header
    end
  end
end
