# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimelinesController, type: :request do
  # general
  let(:record) { factory.create(user_id: current_user.id) }
  let(:factory) { factories.timelines }
  let(:scope) { current_user.timelines.all }
  let(:key) { model_class.to_s.underscore.split('/').last.to_sym }
  let(:model_class) { Db::Timeline }

  # components
  let(:index_component) { Timelines::IndexPageComponent }
  let(:show_component) { Timelines::ShowPageComponent }
  let(:form_component) { Timelines::FormPageComponent }

  # paths
  let(:index_path) { routes.timelines_path(current_user) }
  let(:new_path) { routes.new_timeline_path(current_user) }
  let(:edit_path) { routes.edit_timeline_path(record) }
  let(:show_path) { routes.to(record) }

  # attributes
  let(:valid_attributes) { factory.attributes.merge(name: 'new name') }
  let(:invalid_attributes) { factory.attributes.merge(name: '') }

  describe 'GET #index' do
    before { record }

    let(:perform_request) { get(index_path) }

    it 'responds with success' do
      perform_request

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(record.name)
    end

    it 'renders the correct component' do
      mock_renderer

      perform_request

      expected_component = index_component.new(
        key.to_s.pluralize.to_sym => scope,
        current_user: current_user,
        owner: current_user
      )
      expect(renderer).to have_rendered_component(expected_component)
    end
  end

  describe 'GET #show' do
    let(:perform_request) { get(show_path) }

    it 'returns with success' do
      perform_request

      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct component' do
      mock_renderer

      perform_request

      expected_component = show_component.new(
        key => record,
        current_user: current_user,
        owner: current_user
      )
      expect(renderer).to have_rendered_component(expected_component)
    end

    context 'when timeline belogongs to another user' do
      before do
        login_user(another_user)
      end

      let(:another_user) { factories.users.create }

      it 'responds with 404 when timeline is not public' do
        perform_request

        expect(response.status).to eq(404)
      end

      it 'responds with 200 when timeline is public' do
        record.public = true
        record.save!

        perform_request

        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #new' do
    let(:perform_request) { get(new_path) }
    let(:record) { model_class.new }

    it 'returns with success' do
      perform_request

      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct component' do
      mock_renderer

      perform_request

      expected_component = form_component.new(
        key => scope.new,
        current_user: current_user,
        owner: current_user
      )
      expect(renderer).to have_rendered_component(expected_component)
    end
  end

  describe 'POST #create' do
    let(:perform_request) { post(index_path, params: params) }

    context 'when payload is valid' do
      let(:params) { { key => valid_attributes } }

      it 'returns with success' do
        perform_request

        expect(response).to redirect_to(index_path)
      end

      it 'creates record' do
        expect { perform_request }.to change(current_user.timelines, :count).by(1)
      end
    end

    context 'when payload is invalid' do
      let(:params) { { key => invalid_attributes } }

      it 'responds with 422' do
        perform_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 're-renders form' do
        mock_renderer

        perform_request

        expected_component = form_component.new(
          key => model_class.new(invalid_attributes),
          current_user: current_user,
          owner: current_user
        )
        expect(renderer).to have_rendered_component(expected_component)
      end
    end
  end

  describe 'GET #edit' do
    let(:perform_request) { get(edit_path) }

    it 'returns with success' do
      perform_request

      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct component' do
      mock_renderer

      perform_request

      expected_component = form_component.new(
        key => record,
        current_user: current_user,
        owner: current_user
      )
      expect(renderer).to have_rendered_component(expected_component)
    end
  end

  describe 'PATCH #update' do
    let(:perform_request) { patch(show_path, params: params) }

    context 'when payload is valid' do
      let(:params) { { key => valid_attributes } }

      it 'redirects to index' do
        perform_request

        expect(response).to redirect_to(index_path)
      end

      it 'creates record' do
        expect { perform_request }.to change { record.reload.name }.to('new name')
      end
    end

    context 'when payload is invalid' do
      let(:params) { { key => invalid_attributes } }

      it 'returns with success' do
        perform_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 're-renders form' do
        mock_renderer

        perform_request

        record.attributes = invalid_attributes
        expected_component = form_component.new(
          key => record,
          current_user: current_user,
          owner: current_user
        )
        expect(renderer).to have_rendered_component(expected_component)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:perform_request) { delete(show_path) }

    it 'redirects to index' do
      perform_request

      expect(response).to redirect_to(index_path)
    end

    it 'deletes record' do
      record

      expect { perform_request }.to change(current_user.timelines, :count).by(-1)
    end
  end
end
