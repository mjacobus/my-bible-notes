# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Renderers::Svg::BaseElement do
  subject(:element) { described_class.new(event, helper) }

  let(:helper) { instance_double(Timeline::Renderers::Svg::Helper, helper_attributes) }
  let(:event) { instance_double(Timeline::Event, event_attributes) }
  let(:helper_attributes) { {} }
  let(:event_attributes) do
    {
      time: double(to_s: 'the-time'),
      explanation: 'the-explanation'
    }
  end

  describe '#explanation' do
    it 'includes event date and explanation' do
      expected = <<~STR.strip
        the-time: the-explanation
      STR

      expect(element.explanation).to eq(expected)
    end
  end
end
