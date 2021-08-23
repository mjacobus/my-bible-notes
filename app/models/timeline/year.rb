# frozen_string_literal: true

module Timeline
  class Year
    def initialize(year)
      @year = Integer(year)
    end

    def to_i
      @year
    end

    def to_s
      I18n.t('app.messages.year_with_era', year: to_i.abs, era: localized_era)
    end

    def common_era?
      to_i.positive?
    end

    def localized_era
      I18n.t("app.attributes.#{era.downcase}")
    end

    def era
      common_era? ? 'CE' : 'BCE'
    end
  end
end
