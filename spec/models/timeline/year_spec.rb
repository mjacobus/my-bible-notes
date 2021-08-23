# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Year do
  specify '#to_s returns localized year with era' do
    expect(described_class.new(-2).to_s).to eq('2 a.C.')
  end
end
