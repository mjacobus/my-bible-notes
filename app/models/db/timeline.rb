# frozen_string_literal: true

class Db::Timeline < ApplicationRecord
  belongs_to :user
  default_scope -> { order(:name) }
  scope :by_slug, ->(slug) { find_by!(slug: slug) }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }

  def slug=(value)
    super(value.to_s.parameterize)
  end

  delegate :username, to: :user
end
