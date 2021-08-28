# frozen_string_literal: true

class Db::TimelineEntry < ApplicationRecord
  VALID_PRECISIONS = Timeline::Year::PRECISIONS

  belongs_to :timeline

  default_scope -> { order(:from_year) }
  validates :title, presence: true
  validates :from_year, presence: true
  validates :from_precision, presence: true, inclusion: { in: VALID_PRECISIONS }
  validates :to_year, presence: true
  validates :to_precision, presence: true, inclusion: { in: VALID_PRECISIONS }

  validate :validate_years

  def from_era
    if from_year.to_i.positive?
      return I18n.t('app.attributes.ce')
    end

    I18n.t('app.attributes.bce')
  end

  def formatted_from_year
    "#{from_year.to_i.abs} #{from_era}"
  end

  def to_era
    if to_year.to_i.positive?
      return I18n.t('app.attributes.ce')
    end

    I18n.t('app.attributes.bce')
  end

  def formatted_to_year
    "#{to_year.to_i.abs} #{to_era}"
  end

  def single_year?
    from_year == to_year
  end

  private

  def validate_years
    validate_year(:from_year)
    validate_year(:to_year)
  end

  def validate_year(type)
    year = send(type).to_i

    if year.zero? || year < -4050 || year > Time.zone.today.year
      errors.add(type, I18n.t('app.messages.invalid_year'))
    end
  end
end
