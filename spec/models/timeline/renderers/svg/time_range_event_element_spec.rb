# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Renderers::Svg::TimeRangeEventElement do
  subject(:element) { described_class.new(event, helper) }
  let(:event) { instance_double(Timeline::Event, event_attributes) }
  let(:helper) { instance_double(Timeline::Renderers::Svg::Helper, helper_attributes) }
  let(:event_attributes) do
    { lane_number: 0 }
  end
  let(:helper_attributes) do
    { padding_top: 10 }
  end


  describe '#y' do
    it 'is same as padding top when lane is the first' do
      expect(element.y).to eq(10)
    end
  end
end
