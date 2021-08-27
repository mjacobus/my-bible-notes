# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class TextElement
        attr_reader :text
        attr_reader :attributes

        def initialize(text, attributes = {})
          @text = text
          @attributes = attributes
        end

        def tag
          :text
        end
      end
    end
  end
end
