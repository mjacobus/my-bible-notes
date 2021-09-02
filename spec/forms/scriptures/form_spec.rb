# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scriptures::Form, type: :model do
  subject(:form) { described_class.new(scripture) }

  let(:scripture) { factory.build }
  let(:factory) { factories.scriptures }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:verses) }

  it 'validates chapters' do
    form.book = 'genesis'
    form.verses = '70:1'

    expect(form).not_to be_valid
    expect(form.errors[:verses]).to include('Capítulo não existe: 70')
  end

  it 'validates verses' do
    form.book = 'genesis'
    form.verses = '1:1; 2:87'

    expect(form).not_to be_valid
    expect(form.errors[:verses]).to include('Versículo não existe: 2:87')
  end
end
