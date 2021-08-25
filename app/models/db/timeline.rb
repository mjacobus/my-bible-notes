# frozen_string_literal: true

class Db::Timeline < ApplicationRecord
  belongs_to :user
  has_many :entries, class_name: 'TimelineEntry', dependent: :destroy

  default_scope -> { order(:name) }
  scope :by_slug, ->(slug) { find_by!(slug: slug) }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }

  def slug=(value)
    super(value.to_s.parameterize)
  end

  delegate :username, to: :user

  def to_param
    slug
  end

  def create_model
    Timeline::Timeline.new(
      name: timeline.name,
      events: entries.map do |entries|
        create_event_from_db_entry(entries)
      end
    )
  end

  private

  def create_event_from_db(entry)
    Timeline::Event.new(
      name: entry.name,
      time: Timeline::Time.new(
        from: Timeline::Year.new(from: entry.to, precision: entry.to_precision),
        to: Timeline::Year.new(to: entry.to, precision: entry.to_precision)
      ),
      explanation: entry.explanation,
      color: entry.color
    )
  end
end
