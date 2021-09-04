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
  has_and_belongs_to_many :tags

  scope :ordered, -> { order(:book_number) }
  scope :parents, -> { where(parent_id: nil) }
  scope :with_dependencies, -> { includes([:related_scriptures]) }

  delegate :username, to: :user

  def to_s
    "#{book_instance.localized_name} #{verses}"
  end

  def scripture_and_title
    "#{self} - #{title}"
  end

  def book=(book)
    @book_instance = nil
    super(book)
    set_book_number
  end

  def book_instance
    @book_instance ||= self.class.bible.find(book)
  end

  def self.bible
    @bible = Bible::Factory.new.from_config
  end

  private

  def set_book_number
    if book_instance
      self.book_number = book_instance.number
    end
  end
end
