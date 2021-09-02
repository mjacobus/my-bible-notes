# frozen_string_literal: true

module Scriptures
  class Form < Base::Form
    attributes :title, :book, :verses, :description, :parent_id
    validates :book, presence: true
    validates :verses, presence: true
    validates :title, presence: true

    validate :verses_validation
    validate :parent_validation

    private

    def verses_validation
      book_instance&.parse(verses)
    rescue Bible::Errors::InvalidChapterError => exception
      errors.add(:verses, error_message(:invalid_chapter, chapter: exception.chapter))
    rescue Bible::Errors::InvalidVerseError => exception
      errors.add(:verses,
                 error_message(:invalid_verse, verse: "#{exception.chapter}:#{exception.verse}"))
    end

    def parent_validation
      unless parent_id
        return
      end

      if parent&.user_id == record.user_id
        return
      end

      errors.add(:title, error_message(:invalid_parent))
    end

    def parent
      record.class.where(id: parent_id).first
    end

    def book_instance
      @record.book_instance
    end
  end
end
