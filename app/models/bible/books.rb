# frozen_string_literal: true

module Bible
  class Books
    include Enumerable

    def initialize(books)
      @books = books.freeze
    end

    def each(&block)
      @books.each(&block)
    end

    def size
      @books.size
    end

    def find(number_slug_or_name)
      value = number_slug_or_name
      book = @books.find { |book| book.slug == value }
      book ||= @books.find { |book| book.number == value.to_i }
    end
  end
end
