# frozen_string_literal: true

module Scriptures
  class Form < Base::Form
    attributes :title, :book, :verses, :description
    validates :book, presence: true
    validates :verses, presence: true
    validates :title, presence: true

    validate :verses_validation

    def verses_validation
      book_instance&.parse(verses)
    rescue Bible::Errors::InvalidChapterError => exception
      errors.add(:verses, error_message(:invalid_chapter, chapter: exception.chapter))
    rescue Bible::Errors::InvalidVerseError => exception
      errors.add(:verses,
                 error_message(:invalid_verse, verse: "#{exception.chapter}:#{exception.verse}"))
    end

    # def attributes=(params)
    #   raise params.inspect
    # end


    private

    def book_instance
      @record.book_instance
    end
  end
end
