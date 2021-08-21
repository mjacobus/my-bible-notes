# frozen_string_literal: true

class OauthConfigFactory
  def from_env(oauth_config)
    OauthConfig.new(
      provider: oauth_config['provider'],
      uid: oauth_config['uid'],
      name: oauth_config['info']['name'],
      email: oauth_config['info']['email'],
      avatar: oauth_config['info']['image']
    )
  end
end
