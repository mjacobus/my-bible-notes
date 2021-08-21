# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user_session_service) { instance_double(UserSessionService) }

  before do
    allow(UserSessionService)
      .to receive(:new).with(session: session)
      .and_return(user_session_service)
  end

  describe 'GET #create' do
    before do
      request.env['omniauth.auth'] = 'foo-bar'

      allow(user_session_service).to receive(:create_from_oauth)
    end

    it 'redirects to /' do
      get :create, params: { provider: 'provider-name' }

      expect(response).to redirect_to('/')
    end

    it 'calls the correct service' do
      get :create, params: { provider: 'provider-name' }

      expect(user_session_service).to have_received(:create_from_oauth).with('foo-bar')
    end
  end

  describe 'GET #destroy' do
    before do
      allow(user_session_service).to receive(:destroy)
    end

    it 'redirects to /' do
      get :destroy

      expect(response).to redirect_to('/')
    end

    it 'logs user out' do
      session['user_id'] = 1

      get :destroy

      expect(user_session_service).to have_received(:destroy)
    end
  end
end
