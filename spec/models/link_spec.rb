require 'spec_helper'

describe Link do

  let(:link) { create(:link) }

  it 'has a valid factory' do
    expect(link).to be_valid
  end

  describe '#to_params' do
    it 'uses #short_url' do
      expect(link.to_params).to eq link.short_url
    end
  end

end
