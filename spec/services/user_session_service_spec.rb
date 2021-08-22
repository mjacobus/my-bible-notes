# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe UserSessionService do
  subject(:service) { described_class.new(session: session, oauth_config_factory: factory) }

  let(:session) { {} }
  let(:factory) { instance_double(OauthConfigFactory) }
  let(:user) { Db::User.last }

  describe '#create_from_oauth' do
    before do
      allow(factory).to receive(:from_env)
        .with(oauth_payload)
        .and_return(oauth_config)
    end

    let(:oauth_payload) { { payload: 'the-payload' } }
    let(:oauth_config) do
      OauthConfig.new(
        name: 'the-name',
        uid: 'the-uid',
        email: 'the-email',
        provider: 'the-provider',
        avatar: 'the-avatar'
      )
    end
    let(:perform) { service.create_from_oauth(oauth_payload) }

    context 'when user does not exist' do
      it 'creates an user' do
        factories.users.create

        expect { perform }.to change(Db::User, :count).by(1)

        expect(user.name).to eq('the-name')
        expect(user.email).to eq('the-email')
        expect(user.avatar).to eq('the-avatar')
        expect(user.oauth_provider).to eq('the-provider')
        expect(user.oauth_uid).to eq('the-uid')
        expect(user).not_to be_master
        expect(user).to be_enabled
      end
    end

    context 'when the user exists' do
      before do
        Db::User.create!(
          oauth_provider: oauth_config.provider,
          oauth_uid: oauth_config.uid,
          email: 'other-email',
          name: 'other-name',
          avatar: 'other-avatar',
          username: 'foo'
        )
      end

      it 'updates the user' do
        expect { perform }.not_to change(Db::User, :count)

        expect(user.name).to eq('the-name')
        expect(user.email).to eq('the-email')
        expect(user.avatar).to eq('the-avatar')
        expect(user.oauth_provider).to eq('the-provider')
        expect(user.oauth_uid).to eq('the-uid')
        expect(user).not_to be_master
        expect(user).not_to be_enabled
      end
    end

    it 'logs in user' do
      perform

      expect(session['user_id']).to eq(user.id)
    end

    context 'when user is the first one in the database' do
      it 'sets the user as enabled' do
        perform

        expect(user).to be_enabled
      end

      it 'sets the user as master' do
        perform

        expect(user).to be_master
      end
    end
  end

  describe '#current_user' do
    context 'when session id is present and user is enabled' do
      before do
        session['user_id'] = factories.users.create(enabled: true).id
      end

      it 'returns the current user' do
        expect(service.current_user).to eq(user)
      end
    end

    context 'when session id is present but user is not enabled' do
      before do
        session['user_id'] = factories.users.create(enabled: false).id
      end

      it 'returns nil' do
        expect(service.current_user).to be_nil
      end
    end

    it 'returns nil' do
      expect(service.current_user).to be_nil
    end
  end

  describe '#destroy' do
    it 'destroys the user session' do
      session['user_id'] = 'foo'

      service.destroy

      expect(session).to eq({})
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
