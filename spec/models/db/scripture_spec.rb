# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::Scripture, type: :model do
  subject(:scripture) { described_class.new }

  it { is_expected.to belong_to(:parent_scripture).class_name('Db::Scripture') }

  it 'has many related_scriptures' do
    expect(scripture).to have_many(:related_scriptures)
      .class_name('Db::Scripture')
      .dependent(:restrict_with_exception)
  end

  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:verses) }

  describe '#to_s' do
    it 'converts the bible scripture to string' do
      scripture.book = 'genesis'
      scripture.verses = '2:1-3'

      expect(scripture.to_s).to eq('Gênesis 2:1-3')
    end
  end
end
