# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Routes do
  subject(:routes) { described_class.new }

  let(:user) { factories.users.create }
  let(:timeline) { factories.timelines.create(user_id: user.id) }
  let(:scripture) { factories.scriptures.create(user_id: user.id) }
  let(:entry) { factories.timeline_entries.create(timeline_id: timeline.id) }
  let(:tag) { factories.scripture_tags.create(user_id: user.id) }

  describe 'timeline routes' do
    it 'resolves #timelines_path' do
      path = routes.timelines_path(user)

      expect(path).to eq("/#{user.username}/timelines")
    end

    it 'resolves #timeline_path' do
      path = routes.timeline_path(timeline)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}")
    end

    it 'resolves #new_timeline_path' do
      path = routes.new_timeline_path(user)

      expect(path).to eq("/#{user.username}/timelines/new")
    end

    it 'resolves #edit_timeline_path' do
      path = routes.edit_timeline_path(timeline)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}/edit")
    end

    it 'is compatible with #to' do
      path = routes.to(timeline)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}")
    end
  end

  describe 'scripture routes' do
    it 'resolves #scriptures_path' do
      path = routes.scriptures_path(user)

      expect(path).to eq("/#{user.username}/scriptures")
    end

    it 'resolves #scripture_path' do
      path = routes.scripture_path(scripture)

      expect(path).to eq("/#{user.username}/scriptures/#{scripture.to_param}")
    end

    it 'resolves #new_scripture_path' do
      path = routes.new_scripture_path(user)

      expect(path).to eq("/#{user.username}/scriptures/new")
    end

    it 'resolves #edit_scripture_path' do
      path = routes.edit_scripture_path(scripture)

      expect(path).to eq("/#{user.username}/scriptures/#{scripture.to_param}/edit")
    end

    it 'is compatible with #to' do
      path = routes.to(scripture)

      expect(path).to eq("/#{user.username}/scriptures/#{scripture.to_param}")
    end
  end

  describe 'scripture_tags routes' do
    it 'resolves #scripture_tags_path' do
      path = routes.scripture_tags_path(user)

      expect(path).to eq("/#{user.username}/tags")
    end

    it 'resolves #scripture_tag_path' do
      path = routes.scripture_tag_path(tag)

      expect(path).to eq("/#{user.username}/tags/#{tag.to_param}")
    end

    it 'resolves #edit_scripture_tag_path' do
      path = routes.edit_scripture_tag_path(tag)

      expect(path).to eq("/#{user.username}/tags/#{tag.to_param}/edit")
    end

    it 'resolves #edit_path' do
      path = routes.edit_path(tag)

      expect(path).to eq("/#{user.username}/tags/#{tag.to_param}/edit")
    end

    it 'is compatible with #to' do
      path = routes.to(tag)

      expect(path).to eq("/#{user.username}/tags/#{tag.to_param}")
    end
  end

  describe 'timeline entries routes' do
    it 'resolves #timeline_entries_path' do
      path = routes.timeline_entries_path(timeline)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}/entries")
    end

    it 'resolves #timeline_entry_path' do
      path = routes.timeline_entry_path(entry)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}/entries/#{entry.id}")
    end

    it 'resolves #new_timeline_entry_path' do
      path = routes.new_timeline_entry_path(timeline)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}/entries/new")
    end

    it 'resolves #edit_timeline_entry_path' do
      path = routes.edit_timeline_entry_path(entry)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}/entries/#{entry.id}/edit")
    end

    it 'is compatible with #to' do
      path = routes.to(entry)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}/entries/#{entry.id}")
    end
  end
end
