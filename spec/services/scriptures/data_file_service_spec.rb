# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scriptures::DataFileService, type: :model do
  subject(:service) { described_class.new(user_id: user.id, file: file) }

  let(:user) { factories.users.create }
  let(:import) { service.import }
  let(:file) { fixtures_path('scriptures.yml') }

  describe '#import' do
    it 'creates tags' do
      import

      expect(Db::ScriptureTag.where(name: 'Trindade').count).to eq(1)
    end

    it 'imports parent scriptures' do
      import

      expect(Db::Scripture.count).to be_positive

      found = Db::Scripture.where(title: 'Plural magestático - Façamos', user_id: user.id).first!

      expect(found.book).to eq('genesis')
      expect(found.verses).to eq('1:26')
    end

    it 'imports related scriptures' do
      import

      parent = Db::Scripture.where(title: 'Plural magestático - Façamos', user_id: user.id).first!
      child = Db::Scripture.where(title: 'Anjos gritavam de alegria, davam gritos de louvor',
                                  user_id: user.id).first!

      expect(child.parent_id).to eq(parent.id)
    end
  end

  describe '#book_and_verse' do
    it 'returns the book and verse' do
      expect(service.book_and_verse('1 Pedro 1:23')).to eq(['1 Pedro', '1:23'])
      expect(service.book_and_verse('1Ped 1:23')).to eq(['1Ped', '1:23'])
      expect(service.book_and_verse('Salmo 1:23')).to eq(['Salmo', '1:23'])
    end
  end

  describe '#find_book' do
    it 'returns the book and verse' do
      expect(service.find_book('1Pedro').localized_name).to eq('1 Pedro')
      expect(service.find_book('1 Pedro').localized_name).to eq('1 Pedro')
      expect(service.find_book('1 Ped').localized_name).to eq('1 Pedro')
      expect(service.find_book('Salmo').localized_name).to eq('Salmos')
      expect(service.find_book('Exodo').localized_name).to eq('Êxodo')
    end
  end
end
