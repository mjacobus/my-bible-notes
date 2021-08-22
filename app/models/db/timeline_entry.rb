# frozen_string_literal: true

class Db::TimelineEntry < ApplicationRecord
  VALID_PRECISIONS = %w[precise about after before].freeze

  validates :title, presence: true
  validates :year, presence: true
  validate :year_validation
  validates :precision, presence: true, inclusion: { in: VALID_PRECISIONS }
  validates :confirmed, presence: true

  def era
    if year.to_i.positive?
      return I18n.t('app.attributes.ce')
    end

    I18n.t('app.attributes.bce')
  end

  private

  def year_validation
    if year.to_i.zero? || year.to_i < -4050 || year.to_i > Time.zone.today.year
      errors.add(:year, I18n.t('app.messages.invalid_year'))
    end
  end
end
