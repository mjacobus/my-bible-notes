# frozen_string_literal: true

module Bible
  class Book
    attr_reader :name
    attr_reader :chapters
    attr_reader :verses
    attr_reader :slug
    attr_reader :number

    def initialize(name:, chapters:, verses:, slug:, number:)
      @name = name
      @chapters = chapters
      @verses = verses
      @slug = slug
      @number = number
    end

    def localized_name
      I18n.t("app.bible_books.#{slug}")
    end

    def parse(string)
      VersesParser.new(verses).parse(string)
    end
  end
end
