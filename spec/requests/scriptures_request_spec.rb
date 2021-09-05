# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScripturesController, type: :request do
  around do |example|
    with_bullet_disabled { example.run }
  end

  # general
  let(:record) { factory.create(user_id: current_user.id) }
  let(:factory) { factories.scriptures }
  let(:scope) { current_user.scriptures.all }
  let(:key) { model_class.to_s.underscore.split('/').last.to_sym }
  let(:model_class) { Db::Scripture }
  let(:form) { Scriptures::Form.new(record).under_profile(current_user) }

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
  let(:valid_attributes) { factory.attributes.merge(title: 'new title', user_id: current_user.id) }
  let(:invalid_attributes) { factory.attributes.merge(title: '', user_id: current_user.id) }

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
  end

  describe 'GET #new' do
    let(:perform_request) { get(new_path) }
    let(:record) { model_class.new(user_id: current_user.id) }

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
      let(:record) { model_class.new(invalid_attributes.merge(user_id: current_user.id)) }

      it 'responds with 422' do
        perform_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 're-renders form' do
        mock_renderer

        perform_request

        form.valid?

        expected_component = form_component.new(
          form: form,
          current_user: current_user,
          profile_owner: current_user
        )
        expect(renderer).to have_rendered_component(expected_component)
      end
    end
  end

  describe 'POST #create with parent' do
    let(:parent_scripture) { factory.create(user_id: current_user.id) }
    let(:perform_request) { post(index_path, params: params) }
    let(:params) { { key => valid_attributes.merge(parent_id: parent_scripture.id) } }

    it 'creates record' do
      perform_request

      expect(Db::Scripture.all.pluck(:parent_id).compact).to eq([parent_scripture.id])
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
        expect { perform_request }.to change { record.reload.title }.to('new title')
      end
    end

    context 'when payload is invalid' do
      let(:params) { { key => invalid_attributes } }

      it 'returns with success' do
        perform_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      # rubocop:disable RSpec/ExampleLength
      it 're-renders form' do
        mock_renderer

        perform_request

        form.attributes = invalid_attributes
        form.valid?

        record.attributes = invalid_attributes
        expected_component = form_component.new(
          form: form,
          current_user: current_user,
          profile_owner: current_user
        )
        expect(renderer).to have_rendered_component(expected_component)
      end
      # rubocop:enable RSpec/ExampleLength
    end
  end

  describe 'PATCH #update with tags' do
    let(:perform_request) { patch(show_path, params: params) }
    let(:params) { { key => { tags_string: 'foo, bar' } } }

    it 'creates tags' do
      expect { perform_request }.to change(Db::ScriptureTag, :count).by(2)
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
