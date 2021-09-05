# frozen_string_literal: true

module Scriptures
  class Form < Base::Form
    attributes :title, :book, :verses, :description, :parent_id
    validates :book, presence: true
    validates :verses, presence: true
    validates :title, presence: true

    validate :verses_validation
    validate :parent_validation

    attr_writer :tags_string

    def tags_string
      @tags_string ||= tags_to_string
    end

    private

    def tags_to_string
      record.tags.pluck(:name).join(',')
    end

    def persist_data
      record.save!
      ids = tags.map do |tag|
        find_or_create_tag(tag, record.user_id)
      end
      record.tag_ids = ids.uniq
    end

    def verses_validation
      book_instance&.parse(verses)
    rescue Bible::Errors::InvalidChapterError => exception
      errors.add(:verses, error_message(:invalid_chapter, chapter: exception.chapter))
    rescue Bible::Errors::InvalidVerseError => exception
      errors.add(:verses,
                 error_message(:invalid_verse, verse: "#{exception.chapter}:#{exception.verse}"))
    end

    def tags
      tags_string.split(',').map(&:strip)
    end

    def find_or_create_tag(name, user_id)
      Db::ScriptureTag.find_or_create_by_name(name, user_id: user_id).id
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
