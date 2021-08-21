# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchParams do
  subject(:params) { described_class.new(hash) }

  let(:hash) { { blank: '', nil: nil, whitespace: ' ', 'present' => 'ok' } }
  let(:protected) { ActionController::Parameters.new(hash) }
  let(:storage) { [] }

  describe '#if' do
    it 'yields value if key is present' do
      params.if(:present) do |value|
        storage << value
      end

      params.if(:nil) do |value|
        storage << value
      end

      params.if(:blank) do |value|
        storage << value
      end

      expect(storage).to eq(['ok'])
    end
  end

  describe '#each' do
    it 'ignores all non present values' do
      params.each do |key, value|
        storage << key
        storage << value
      end

      expect(storage).to eq(%w[present ok])
    end
  end

  describe '#any?' do
    it 'ignores all non present values' do
      expect(params).to be_any(:foo, :bar, :present)
      expect(params).to be_any(%i[foo bar present])
      expect(params).not_to be_any(:foo, :bar, :blank, :nil)
    end
  end
end
