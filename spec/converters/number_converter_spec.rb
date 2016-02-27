require 'rails_helper'

RSpec.describe NumberConverter do
  converter = NumberConverter.new
  describe 'convert' do
    it 'converts "6.54" to its float equivalent' do
      expect(converter.convert('6.54')).to eq(6.54)
    end

    it 'converts "N/A" to nil' do
      expect(converter.convert('N/A')).to eq(nil)
    end

    it 'converts "nan" to nil' do
      expect(converter.convert('nan')).to eq(nil)
    end

    it 'converts "1.4B" to 1400000000' do
      expect(converter.convert('1.4B')).to eq(1400000000)
    end

    it 'converts "1.4M" to 1400000' do
      expect(converter.convert('1.4M')).to eq(1400000)
    end
  end
end
