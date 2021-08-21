# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ControllerAcl do
  subject(:acl) { described_class.new(request) }

  let(:user) { Db::User.new }
  let(:request) { Struct.new(:params).new(controller: controller, action: action) }
  let(:controller) { 'foo_bar/baz' }
  let(:action) { 'index' }

  describe '#authorized?' do
    context 'when user is not authorized to that controller and action' do
      it 'returns false' do
        expect(acl).not_to be_authorized(user)
      end
    end

    context 'when user is authorized to the controller and action' do
      before do
        user.grant_controller_access(controller, action: action)
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

  describe '.controller_actions_for_acl' do
    let(:list) {  described_class.controller_actions_for_acl }

    it 'returns a list of all controller and actions' do
      expect(list).to include('admin/db_users#index')
    end

    it 'does not include garbage' do
      expect(list).not_to include('#')
    end
  end
end
