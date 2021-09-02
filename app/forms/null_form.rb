# frozen_string_literal: true

# rubocop:disable Style/MissingRespondToMissing
class NullForm
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def method_missing(*args)
    @record.send(*args)
  end

  def under_profile(profile)
    @profile_owner = profile
    self
  end

  def target_url
    if record.id
      return urls.to(record)
    end

    urls.send("#{as.pluralize}_path", @profile_owner)
  end

  def as
    param_key
  end

  private

  def urls
    @urls ||= Routes.new
  end

  def singular_route_key
    @record.class.to_s.sub('Db::', '')
  end

  def param_key
    @record.class.to_s.split('::').last.underscore
  end

  def model_class
    @record.class
  end

  def i18n_key
    @record.model_name.i18n_key
  end

  def t(key, **args)
    I18n.t(key, **args)
  end

  # def error_message(key, **args)
  #   t("app.messages.errors.#{key}", **args)
  # end
end
# rubocop:enable Style/MissingRespondToMissing
