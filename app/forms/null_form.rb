# frozen_string_literal: true

class NullForm
  include ActiveModel::Model

  attr_reader :record

  def initialize(record)
    @record = record
  end

  def method_missing(*args)
    record.send(*args)
  end

  def respond_to_missing?(*args)
    record.send(:respond_to_missing?, *args)
  end

  delegate :persisted?, to: :record

  def under_profile(profile)
    @profile_owner = profile
    self
  end

  def target_url
    if record.id
      return urls.to(record)
    end

    urls.send("#{param_key.pluralize}_path", @profile_owner)
  end

  def param_key
    record.class.to_s.split('::').last.underscore
  end

  def method
    record.id ? :patch : :post
  end

  delegate :attributes=, to: :record

  delegate :errors, to: :record

  delegate :class, to: :record

  private

  def urls
    @urls ||= Routes.new
  end
end
