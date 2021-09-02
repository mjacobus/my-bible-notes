# frozen_string_literal: true

module Base
  class Form
    include ActiveModel::Model
    delegate :id, :persisted?, :to_param, to: :@record

    attr_reader :record

    def initialize(record)
      @record = record
    end

    def under_profile(profile)
      @profile_owner = profile
      self
    end

    def save
      if valid?
        record.save!
      end
    end

    delegate :model_name, to: :record

    def attributes=(params)
      params.each do |key, value|
        setter = "#{key}="
        if respond_to?(setter)
          send(setter, value)
        end
      end
    end

    def self.attributes(*args)
      args.each do |attribute|
        delegate attribute, "#{attribute}=", to: :@record
      end
    end

    def target_url
      if record.id
        return urls.to(record)
      end

      urls.send("#{param_key.pluralize}_path", @profile_owner)
    end

    def param_key
      @record.class.to_s.split('::').last.underscore
    end

    private

    def urls
      @urls ||= Routes.new
    end

    def t(key, **args)
      I18n.t(key, **args)
    end

    def error_message(key, **args)
      t("app.messages.errors.#{key}", **args)
    end
  end
end
