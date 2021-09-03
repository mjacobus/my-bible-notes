# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::ScriptureTag do
  it 'has many scriptures' do
    scripture = factories.scriptures.create
    tag = factories.scripture_tags.create

    scripture.tag_ids = [tag.id]

    expect(tag.scriptures.map(&:title)).to include(scripture.title)
  end
end
