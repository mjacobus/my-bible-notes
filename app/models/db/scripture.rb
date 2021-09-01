# frozen_string_literal: true

class Db::Scripture < ApplicationRecord
  belongs_to :user
  belongs_to :parent_scripture,
             class_name: 'Scripture',
             foreign_key: :parent_id,
             inverse_of: :related_scriptures,
             optional: true
  has_many :related_scriptures,
           class_name: 'Scripture',
           foreign_key: 'parent_id',
           dependent: :restrict_with_exception,
           inverse_of: :parent_scripture

  validates :book, presence: true
  validates :verses, presence: true

  delegate :username, to: :user

  def to_s
    "#{book_instance.localized_name} #{verses}"
  end

  def book=(book)
    @book_instance = nil
    super(book)
  end

  def book_instance
    @book_instance ||= self.class.bible.find(book)
  end

  def self.bible
    @bible = Bible::Factory.new.from_config
  end
end
