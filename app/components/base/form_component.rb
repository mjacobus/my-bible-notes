# frozen_string_literal: true

module Base
  module FormComponent
    extend ActiveSupport::Concern

    included do
      has :profile_user
      has :owner
      has :current_user
    end

    def submit_button(form)
      form.submit(class: 'btn btn-primary mt-3 float-right')
    end

    def input_wrapper(&block)
      tag.div(class: 'form-wrapper my-3', &block)
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
