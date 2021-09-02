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

  scope :ordered, -> { order(:book_number) }

  validates :book, presence: true
  validates :verses, presence: true
  validates :title, presence: true

  validate :verses_validation

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

  def verses_validation
    book_instance&.parse(verses)
  rescue Bible::Errors::InvalidChapterError => exception
    errors.add(:verses, error_message(:invalid_chapter, chapter: exception.chapter))
  rescue Bible::Errors::InvalidVerseError => exception
    errors.add(:verses,
               error_message(:invalid_verse, verse: "#{exception.chapter}:#{exception.verse}"))
  end
end
