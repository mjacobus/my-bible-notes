# frozen_string_literal: true

module Base
  module HasAttribute
    extend ActiveSupport::Concern

    MissingArgument = Class.new(StandardError)

    module ClassMethods
      def has(field, public: false, optional: false)
        define_method field do
          if optional
            return get(field)
          end

          get(field) || raise(MissingArgument, "Missing argument: #{field}")
        end
        unless public
          private field
        end
      end
    end
  end
end
