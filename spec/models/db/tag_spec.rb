# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::Tag, type: :model do
  subject(:tag) { factories.scripture_tags.build }

  it { is_expected.to belong_to(:user).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to([:type]) }

  it 'handles slug' do
    tag.name = 'Foo Bar'

    expect { tag.name = 'Baz Bar' }.to change { tag.slug }.from('foo-bar').to('baz-bar')
  end
end
