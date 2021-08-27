# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class YearsMap
        attr_reader :from
        attr_reader :to

        def initialize(from:, to:)
          @from, @to = from, to
        end

        def to_h
          @map ||= resolve
        end

        def position_for(year)
          @map.fetch(year.to_i)
        end

        def length
          to_h.length
        end

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
