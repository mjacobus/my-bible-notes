# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OauthConfigFactory do
  subject(:service) { described_class.new }

  let(:oauth_payload) do
    {
      'provider' => 'google_oauth2',
      'uid' => 'the-uid',
      'info' => {
        'name' => 'the-name',
        'email' => 'the-email',
        'image' => 'the-image'
      }
    }
  end

  describe '#from_env' do
    it 'properly creates an oauth config' do
      config = service.from_env(oauth_payload)

      expect(config).to be_a(OauthConfig)
      expect(config.provider).to eq('google_oauth2')
      expect(config.uid).to eq('the-uid')
      expect(config.name).to eq('the-name')
      expect(config.email).to eq('the-email')
      expect(config.avatar).to eq('the-image')
    end
  end
end
