# frozen_string_literal: true

module Base
  module Bem
    extend ActiveSupport::Concern

    def bem(element = nil, modifier = nil, block: nil)
      block ||= self.class.to_s
      block = block.gsub('::', '_')

      parts = [block]

      if element
        parts << "__#{element}"
      end

      if modifier
        parts << "--#{modifier}"
      end

      parts.join
    end
  end
end
