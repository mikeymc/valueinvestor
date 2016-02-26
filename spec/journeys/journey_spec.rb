require 'rails_helper'

RSpec.describe 'finding stocks' do
  before(:each) do
    Rails.application.load_seed
  end

  it 'enables the user to view stocks' do
    visit '/'
    expect(page).to have_content 'Global Stocks'
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
    expect(stock.find('.current-eps').text).to match /\d+\.\d+/
    expect(stock.find('.dividends-amount').text).to match /\d+\.\d+/
    expect(stock.find('.day-high-price').text).to match /\d+\.\d+/
    expect(stock.find('.day-low-price').text).to match /\d+\.\d+/
    expect(stock.find('.book-value').text).to match /\d+\.\d+/
    expect(stock.find('.price-to-book-ratio').text).to match /\d+\.\d+/
    expect(stock.find('.price-to-earnings-ratio').text).to match /\d+\.\d+/
    expect(stock.find('.year-low-price').text).to match /\d+\.\d+/
    expect(stock.find('.year-high-price').text).to match /\d+\.\d+/
  end

  def see_headers
    expected_row_headers = [
      'Name',
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