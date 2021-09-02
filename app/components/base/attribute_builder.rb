# frozen_string_literal: true

module Base
  module AttributeBuilder
    def attribute(value)
      AttributeWrapperComponent.new(value)
    end
  end
end
