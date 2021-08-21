# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:service) { instance_double(UserSessionService, current_user: 'the-user') }
  let(:skip_login) { true }

  before do
    allow(UserSessionService).to receive(:new).with(session: session).and_return(service)
  end

  describe '#current_user' do
    it 'returns the current user from the user session service' do
      current_user = controller.send(:current_user)

      expect(current_user).to eq('the-user')
    end
  end
end
