# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlAcl do
  subject(:acl) { described_class.new(url) }

  let(:user) { Db::User.new }
  let(:url) { 'http://example.com/users' }
  let(:controller) { 'users' }

  describe '#authorized?' do
    context 'when user is not authorized to that controller and action' do
      it 'returns false' do
        expect(acl).not_to be_authorized(user)
      end
    end

    context 'when user is authorized to the controller and action' do
      before do
        user.grant_controller_access(controller, action: 'index')
      end

      it 'returns true' do
        expect(acl).to be_authorized(user)
      end
    end

    context 'when user is authorized to the controller and all actions' do
      before do
        user.grant_controller_access(controller, action: '*')
      end

      it 'returns true' do
        expect(acl).to be_authorized(user)
      end
    end
  end
end
