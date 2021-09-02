# frozen_string_literal: true

module Base
  module FormComponent
    extend ActiveSupport::Concern

    included do
      has :profile_owner
      has :current_user
    end

    def submit_button(form)
      form.submit(class: 'btn btn-primary mt-3 float-right')
    end

    def input_wrapper(&block)
      tag.div(class: 'form-wrapper my-3', &block)
    end

    def url
      if record.id
        return urls.to(record)
      end

      index_path
    end

    def form_key
      @form_key ||= record.class.to_s.underscore.tr('db/', '')
    end

    private

    def select_input(form, name, collection)
      form.input name, collection: collection, include_blank: true
    end

    def index_link_name
      t("app.links.#{form_key.pluralize}")
    end

    def index_path
      urls.send("#{form_key.pluralize}_path", current_user)
    end

    module ClassMethods
      def record(name)
        has name

        define_method :record do
          send(name)
        end
      end
    end
  end
end
