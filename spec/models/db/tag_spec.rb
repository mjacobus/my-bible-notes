# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::Tag, type: :model do
  subject(:tag) { factories.scripture_tags.build }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(%i[type user_id]) }

  it 'handles slug' do
    tag.name = 'Foo Bar'

    expect { tag.name = 'Baz Bar' }.to change { tag.slug }.from('foo-bar').to('baz-bar')
  end

  describe '#tag_name' do
    specify 'two users can have the same tag name' do
      user1 = factories.users.create
      user2 = factories.users.create

      expect do
        factories.scripture_tags.create(user_id: user1.id, name: 'TagNameY')
        factories.scripture_tags.create(user_id: user2.id, name: 'TagNameY')
      end.to change(described_class, :count).by(2)
    end
  end

  describe '#color' do
    it 'is first set when name is set' do
      tag = described_class.new

      tag.name = 'foo'
      tag.name = 'bar'

      expect(tag.color).to eq(NameBasedColor.new('foo').to_s)
    end
  end
end
