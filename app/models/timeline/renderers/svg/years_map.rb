# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class YearsMap
        attr_reader :from
        attr_reader :to

        def initialize(from:, to:)
          @from = from
          @to = to
        end

        def to_h
          @map ||= resolve
        end

        def position_for(year)
          to_h.fetch(year.to_i)
        end

        delegate :length, to: :to_h

        private

        def resolve
          {}.tap do |map|
            i = 0
            (from..to).each do |year|
              next if year.zero?

              map[year] = i
              i += 1
            end
          end
        end
      end
    end
  end
end
