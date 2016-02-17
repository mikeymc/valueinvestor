require 'rails_helper'

RSpec.describe QuerySetup do
  describe 'generate_list' do
    it 'returns a list of symbols' do
      @qs = QuerySetup.new
      @qs.generate_list
      expect(@qs.list.size).to eq(14935)
      expect(@qs.list[0]).to eq('TIF')
    end
  end
end
