# frozen_string_literal: true

class Db::Scripture < ApplicationRecord
  belongs_to :user
  belongs_to :parent_scripture,
             class_name: 'Scripture',
             foreign_key: :parent_id,
             inverse_of: :related_scriptures
  has_many :related_scriptures,
           class_name: 'Scripture',
           foreign_key: 'parent_id',
           dependent: :restrict_with_exception,
           inverse_of: :parent_scripture

  validates :book, presence: true
  validates :verses, presence: true
end
