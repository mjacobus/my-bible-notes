# frozen_string_literal: true

class Db::Tag < ApplicationRecord
  has_and_belongs_to_many :scriptures
  belongs_to :user
  default_scope -> { order(:name) }

  scope :scripture, -> { where(type: 'Db::ScriptureTag') }

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: %i[type user_id] }

  def name=(value)
    self.slug = value.to_s.parameterize
    self.color ||= NameBasedColor.new(value.to_s)
    super(value)
  end

  def self.find_or_create_by_name(name, user_id:)
    found = where('lower(name) = ?', name.downcase).find_by(user_id: user_id)

    if found
      return found
    end

    create!(name: name, user_id: user_id)
  end
end
