require 'rails_helper'

RSpec.describe ScripturesController, type: :request do
  # general
  let(:record) { factory.create(user_id: current_user.id) }
  let(:factory) { factories.scriptures }
  let(:scope) { current_user.scriptures.all }
  let(:key) { model_class.to_s.underscore.split('/').last.to_sym }
  let(:model_class) { Db::Scripture }

  # components
  let(:index_component) { Scriptures::IndexPageComponent }
  let(:show_component) { Scriptures::ShowPageComponent }
  let(:form_component) { Scriptures::FormPageComponent }

  # paths
  let(:index_path) { routes.scriptures_path(current_user) }
  let(:new_path) { routes.new_scripture_path(current_user) }
  let(:edit_path) { routes.edit_scripture_path(record) }
  let(:show_path) { routes.to(record) }

  # attributes
  let(:valid_attributes) { factory.attributes.merge(title: 'new title') }
  let(:invalid_attributes) { factory.attributes.merge(title: '') }

  describe 'GET #index' do
    before { record }

    let(:perform_request) { get(index_path) }

    it 'responds with success' do
      perform_request

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(record.title)
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
        expect { perform_request }.to change(current_user.scriptures, :count).by(1)
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
        expect { perform_request }.to change { record.reload.title }.to('new title')
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

      expect { perform_request }.to change(current_user.scriptures, :count).by(-1)
    end
  end
end
