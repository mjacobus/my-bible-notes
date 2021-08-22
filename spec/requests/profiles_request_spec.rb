# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :request do
  before do
    admin_user.save!
    login_user(admin_user)
  end

  describe '#edit' do
    let(:perform_request) { get('/profile') }

    it 'responds with success' do
      perform_request

      expect(response).to be_successful
    end

    it 'also responds with success when profile is not complete' do
      admin_user.username = nil
      admin_user.save(validate: false)

      perform_request

      expect(response).to be_successful
    end

    it 'renders the correct component' do
      mock_renderer

      perform_request

      expected_component = Profile::EditPageComponent.new(user: admin_user)
      expect(renderer).to have_rendered_component(expected_component)
    end
  end

  describe '#update' do
    let(:perform_request) { put('/profile', params: { profile: params }) }

    context 'when payload is valid' do
      let(:params) { { username: 'the-username' } }

      it 'responds with success' do
        perform_request

        expect(response).to have_http_status(:ok)
      end

      it 're-renders form' do
        mock_renderer

        perform_request

        expected_component = Profile::EditPageComponent.new(user: admin_user)
        expect(renderer).to have_rendered_component(expected_component)
      end

      it 'updates the username' do
        expect { perform_request }.to change { admin_user.reload.username }.to('the-username')
      end

      it 'displays message' do
        perform_request

        expect(response.body).to include(I18n.t('app.messages.saved'))
      end
    end

    context 'when payload is invalid' do
      let(:params) { { username: '' } }

      it 're renders edit page' do
        perform_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the correct component' do
        mock_renderer

        perform_request

        expected_component = Profile::EditPageComponent.new(user: admin_user)
        expect(renderer).to have_rendered_component(expected_component)
      end
    end
  end
end
