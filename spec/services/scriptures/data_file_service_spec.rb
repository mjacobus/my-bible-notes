# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scriptures::DataFileService, type: :model do
  let(:user) { factories.users.create }
  let(:import) { described_class.new(user_id: user.id, file: file).import }
  let(:file) { fixtures_path('scriptures.yml') }

  describe '#import' do
    it 'creates tags' do
      import

      expect(Db::ScriptureTag.where(name: 'Trindade').count).to eq(1)
    end

    it 'imports parent scriptures' do
      import

      found = Db::Scripture.where(title: '')

      expect(found)
    end
  end
end
