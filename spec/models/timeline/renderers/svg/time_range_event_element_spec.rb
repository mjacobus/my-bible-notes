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
    { padding_top: 10, lane_height: 12, lane_spacing: 3 }
  end

  describe '#y' do
    context 'when first lane' do
      before do
        event_attributes[:lane_number] = 0
      end

      it 'is same as padding top' do
        expect(element.y).to eq(10)
      end
    end

    context 'when second lane' do
      before do
        event_attributes[:lane_number] = 1
      end

      it 'is padding top + lane height + spacing' do
        expect(element.y).to eq(10 + 12 + 3)
      end
    end
  end
end
