# frozen_string_literal: true

class UserSessionService
  def initialize(session:, oauth_config_factory: OauthConfigFactory.new)
    @session = session
    @oauth_config_factory = oauth_config_factory
  end

  def create_from_oauth(oauth)
    oauth_config = @oauth_config_factory.from_env(oauth)
    user = find_or_create_by_oauth(oauth_config)
    user.save(validate: false)

    @session['user_id'] = user.id
  end

  def current_user
    Db::User.find_by(id: @session['user_id'], enabled: true)
  end

  def destroy
    @session.delete('user_id')
  end

  private

  # rubocop:disable Metrics/MethodLength
  def find_or_create_by_oauth(config)
    user = Db::User.find_or_initialize_by(
      oauth_provider: config.provider,
      oauth_uid: config.uid
    )

    if Db::User.count.zero?
      user.master = true
    end

    unless user.persisted?
      user.enabled = true
    end

    user.attributes = {
      email: config.email,
      name: config.name,
      avatar: config.avatar
    }

    user
  end
  # rubocop:enable Metrics/MethodLength
end
