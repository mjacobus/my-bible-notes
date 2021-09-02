# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include Base::HasAttribute
  include Base::CurrentUser
  include Base::Bem
  include Base::Icons
  include Base::AttributeBuilder

  has :profile_owner

  def initialize(options = {})
    @options = options
  end

  private

  def urls
    @urls ||= Routes.new
  end

  def get(key)
    @options[key]
  end

  def t(key, **options)
    I18n.t(key, **options)
  end
end
