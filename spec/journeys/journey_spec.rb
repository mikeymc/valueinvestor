require 'rails_helper'

RSpec.describe 'finding stocks' do
  it 'enables the user to view stocks' do
    visit '/'
    expect(page).to have_content 'Global Stocks'
  end
end
