# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Routes do
  subject(:routes) { described_class.new }

  let(:user) { factories.users.create }
  let(:timeline) { factories.timelines.create(user_id: user.id) }

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

  describe '#to' do
    it 'resolves timeline path' do
      path = routes.to(timeline)

      expect(path).to eq("/#{user.username}/timelines/#{timeline.slug}")
    end
  end
end
