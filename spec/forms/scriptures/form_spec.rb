# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scriptures::Form, type: :model do
  subject(:form) { described_class.new(scripture) }

  let(:scripture) { scriptures.build }
  let(:scriptures) { factories.scriptures }

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

  describe 'parent validation' do
    let(:user) { factories.users.create }
    let(:scripture) { scriptures.build(user_id: user.id) }

    context 'when parent belongs to another user owner' do
      it 'is not valid' do
        form.parent_id = scriptures.create.id

        expect(form).not_to be_valid
        expect(form.errors[:title]).to include('Texto relacionado inválido')
      end
    end

    context 'when parent belongs to user' do
      it 'is valid' do
        form.parent_id = scriptures.create(user_id: user.id).id

        expect(form).to be_valid
      end
    end

    context 'when parent id does not exist' do
      it 'is valid' do
        form.parent_id = -1

        expect(form).not_to be_valid
      end
    end

    context 'when parent id is nil' do
      it 'is valid' do
        form.parent_id = nil

        expect(form).to be_valid
      end
    end
  end

  describe '#tags_string=' do
    it 'creates or update tags by names' do
      factories.scripture_tags.create(
        name: 'imortal soul',
        user_id: scripture.user.id
      )

      form.tags_string = 'Trinity, Imortal Soul'

      expect { form.save }.to change { scripture.user.tags.count }.by(1)
    end
  end

  describe '#parent_id=' do
    let(:scripture) { scriptures.build(parent_id: parent.id) }
    let(:parent) { scriptures.create }

    it 'sets parent id when record is new' do
      form.attributes = { parent_id: nil }

      expect(form.parent_id).to be_nil
    end

    it 'does not return parent id when editing record' do
      scripture.save!

      form.attributes = { parent_id: nil }

      expect(form.parent_id).to eq parent.id
    end
  end
end
