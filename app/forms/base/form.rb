# frozen_string_literal: true

module Base
  class Form
    include ActiveModel::Model
    delegate :id, :persisted?, :to_param, to: :@record

    attr_reader :record

    def initialize(record)
      @record = record
    end

    def save
      if valid?
        @record.save!
      end
    end

    # TODO: Fix the following issue
    #
    # This hack is not working very well with simple_form i18n file.
    # AR attributes i18n is also not working well.
    def model_name
      @model_name ||= ActiveModel::Name.new(model_class, nil, singular_route_key).tap do |name|
        name.param_key = param_key
        name.i18n_key = i18n_key
      end
    end

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

      urls.send("#{form_key.pluralize}_path", current_user)
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

    def error_message(key, **args)
      t("app.messages.errors.#{key}", **args)
    end
  end
end
