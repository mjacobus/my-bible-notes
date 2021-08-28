# frozen_string_literal: true

module Timeline
  class Year
    InvalidYear = Class.new(ArgumentError)
    InvalidPrecision = Class.new(ArgumentError)

    PRECISIONS = %w[precise about before after].freeze

    # rubocop:disable Metrics/MethodLength
    def initialize(year, precision: :precise)
      precision ||= :precise
      begin
        @year = Integer(year)
      rescue ArgumentError
        raise InvalidYear
      end

      if @year.zero?
        raise InvalidYear
      end

      @precision = precision.to_s

      unless PRECISIONS.include?(@precision)
        raise InvalidPrecision
      end
    end
    # rubocop:enable Metrics/MethodLength

    def to_i
      @year
    end

    def next
      self.class.new(to_i.next, precision: @precision)
    end

    def pred
      self.class.new(to_i.pred, precision: @precision)
    end

    def to_s
      key = precise? ? 'year_with_era' : 'year_with_era_and_precision'

      I18n.t(
        "app.messages.#{key}",
        year: to_i.abs,
        era: localized_era,
        precision: localized_precision
      )
    end

    def common_era?
      to_i.positive?
    end

    def localized_precision
      I18n.t("app.attributes.short_precisions.#{@precision}", default: '')
    end

    def localized_era
      I18n.t("app.attributes.#{era.downcase}")
    end

    def era
      common_era? ? 'CE' : 'BCE'
    end

    def precise?
      @precision == 'precise'
    end
  end
end
