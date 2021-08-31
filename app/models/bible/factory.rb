# frozen_string_literal: true

module Bible
  class Factory
    def from_config(file = Rails.root.join('config/bible.yml'))
      books = YAML.load_file(file)['books'].map do |book|
        attrs = book.symbolize_keys
        Book.new(**attrs)
      end

      Books.new(books)
    end
  end
end
