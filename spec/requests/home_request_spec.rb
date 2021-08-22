require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET #index' do
    before do
      login_user(regular_user)
    end

    context 'when profile is incomplete' do
      before do
        regular_user.username = nil
        regular_user.save(validate: false)
      end

      it 'redirects to profile edit page' do
        get '/'

        expect(response).to redirect_to(edit_profile_path)
      end
    end

    context 'when profile is complete' do
      it 'redirects to profile edit page' do
        get '/'

        expect(response).to be_successful
      end
    end
  end
end

