# frozen_string_literal: true

class OauthConfig
  attr_reader :provider
  attr_reader :uid
  attr_reader :name
  attr_reader :email
  attr_reader :avatar

  def initialize(attributes)
    @provider = attributes.fetch(:provider)
    @uid = attributes.fetch(:uid)
    @name = attributes.fetch(:name)
    @email = attributes.fetch(:email)
    @avatar = attributes.fetch(:avatar)
  end
end
