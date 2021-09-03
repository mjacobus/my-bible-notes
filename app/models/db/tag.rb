# frozen_string_literal: true

class Db::Tag < ApplicationRecord
  has_and_belongs_to_many :scriptures
  belongs_to :user, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: [:type] }

  def name=(value)
    self.slug = value.to_s.parameterize
    super(value)
  end
end
