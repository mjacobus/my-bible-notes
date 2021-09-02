# frozen_string_literal: true

# rubocop:disable Style/MissingRespondToMissing
class NullForm
  include ActiveModel::Model

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

  def param_key
    record.class.to_s.split('::').last.underscore
  end

  def method
    record.id ? :patch : :post
  end

  def attributes=(params)
    record.attributes = params
  end

  def errors
    record.errors
  end

  def class
    record.class
  end

  private

  def urls
    @urls ||= Routes.new
  end
end
# rubocop:enable Style/MissingRespondToMissing
