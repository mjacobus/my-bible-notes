# frozen_string_literal: true

class Db::Timeline < ApplicationRecord
  belongs_to :user
  has_many :entries, class_name: 'TimelineEntry', dependent: :destroy

  default_scope -> { order(:name) }
  scope :by_slug, ->(slug) { find_by!(slug: slug) }
  scope :public_timelines, -> { where(public: true) }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }

  def slug=(value)
    super(value.to_s.parameterize)
  end

  delegate :username, to: :user
end
