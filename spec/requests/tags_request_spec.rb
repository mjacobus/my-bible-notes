# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :request do
  # general
  let(:record) { factory.create(user_id: current_user.id) }
  let(:factory) { factories.scripture_tags }
  let(:scope) { current_user.tags.scripture.all }
  let(:key) { :tag }
  let(:model_class) { Db::ScriptureTag }
  let(:form) { NullForm.new(record).under_profile(current_user) }

  # components
  let(:index_component) { Tags::IndexPageComponent }
  let(:show_component) { Tags::ShowPageComponent }
  let(:form_component) { Tags::FormPageComponent }

  # paths
  let(:index_path) { routes.scripture_tags_path(current_user) }
  let(:new_path) { routes.new_scripture_tag_path(current_user) }
  let(:edit_path) { routes.edit_path(record) }
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
        collection: scope,
        current_user: current_user,
        profile_owner: current_user
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
        record: record,
        current_user: current_user,
        profile_owner: current_user
      )
      expect(renderer).to have_rendered_component(expected_component)
    end

    context 'when tag belongs to another user' do
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
        form: form,
        current_user: current_user,
        profile_owner: current_user
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

      it 'updates record' do
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

        form.attributes = invalid_attributes

        expected_component = form_component.new(
          form: form,
          current_user: current_user,
          profile_owner: current_user
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

      expect { perform_request }.to change(current_user.tags, :count).by(-1)
    end
  end
end
