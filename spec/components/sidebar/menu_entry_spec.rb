# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sidebar::MenuEntry do
  subject(:entry) { described_class.new('foo', url) }

  let(:url) { 'http://example.com/admin/db_users' }

  describe '#active' do
    it 'returns true when controller matches current controller' do
      expect(entry).to be_active("#{url}/1/edit")
    end

    it 'returns false when controller does not match current controller' do
      expect(entry).not_to be_active('/users')
    end

    it 'returns false when url is nonsense' do
      expect(entry).not_to be_active('/foobar')
    end

    it 'returns true when any of its children is active' do
      child_url = '/users'
      child = described_class.new('Users', child_url)

      expect { entry.append_child(child) }
        .to change { entry.active?(child_url) }.from(false).to(true)
    end

    it 'returns true when it is a sub resource of a controller' do
      skip 'write a new test when there are other resources'

      entry = described_class.new('Something', '/users')

      expect(entry).to be_active('http://localhost:3001/territories/634/contacts')
    end

    it 'returns false for /' do
      entry = described_class.new('Something', '/')

      expect(entry).not_to be_active('http://localhost:3001/territories/commercial_territories/634/contacts')
    end

    it 'returns false for http://localhost:3001' do
      entry = described_class.new('Something', 'http://localhost:3001')

      expect(entry).not_to be_active('http://localhost:3001/territories/commercial_territories/634/contacts')
    end

    it 'returns false when no child is active' do
      entry = described_class.new('Something', '').tap do |e|
        e.append_child(described_class.new('Users', '/users'))
      end

      expect(entry).not_to be_active('/')
    end
  end
end
