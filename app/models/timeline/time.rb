# frozen_string_literal: true

module Timeline
  class Time
    attr_reader :from, :to

    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def single_year?
      from.to_i == to.to_i
    end

    def overlap_with?(other, inclusive: false)
      if cover_year?(other.from,
                     inclusive: inclusive) || cover_year?(other.to, inclusive: inclusive)
        return true
      end

      unless other.single_year?
        cover_year?(other.from.next,
                    inclusive: inclusive) || cover_year?(other.to.pred, inclusive: inclusive)
      end
    end

    def cover_year?(year, inclusive: true)
      diff = inclusive ? 0 : 1
      range = (from.to_i + diff).to_i..(to.to_i - diff).to_i
      range.cover?(year.to_i)
    end

    def length
      result = ((to.to_i - from.to_i) + 1).abs
      if cover_year?(0)
        return result - 1
      end
      result
    end
  end
end
