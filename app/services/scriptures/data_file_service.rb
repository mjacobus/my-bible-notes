# frozen_string_literal: true

module Scriptures
  class DataFileService
    attr_reader :file
    attr_reader :user_id
    attr_reader :data

    def initialize(user_id:, file:)
      @user_id = user_id
      @file = file
      @data = YAML.load_file(file).deep_symbolize_keys.freeze
    end

    def import
      data[:scriptures].each do |scripture|
        import_scripture(scripture)
      end
    end

    def book_and_verse(title)
      parts = title.split
      book = parts.shift

      unless /\d/.match?(parts.first[0])
        book += " #{parts.shift}"
      end

      verses = parts.join(' ')

      [book, verses]
    end

    def find_book(name)
      partial_match = name.gsub(/\s/, '').downcase

      found = bible.to_a.find do |book|
        normalized = book.localized_name.gsub(/\s/, '').downcase
        normalized.match(partial_match)
      end

      if found
        return found
      end

      partial_match = partial_match.parameterize
      found = bible.to_a.find do |book|
        normalized = book.localized_name.parameterize.delete('-').downcase
        normalized.match(partial_match)
      end

      if found
        return found
      end

      raise("Cannot find by #{name} partial match: #{partial_match}")
    end

    private

    def import_scripture(scripture, parent_id: nil)
      book, verses = find_by_title(scripture[:title])

      form = Scriptures::Form.new(user.scriptures.build)
      form.attributes = {
        title: scripture[:description],
        book: book.slug,
        verses: verses,
        tags_string: Array.wrap(scripture[:tags]).join(','),
        parent_id: parent_id
      }
      if form.save
        Array.wrap(scripture[:related]).each do |related|
          import_scripture(related, parent_id: form.record.id)
        end
      else
        p "Cannot import #{form.record}"
      end
    end

    def find_by_title(title)
      name, verses = book_and_verse(title)
      [find_book(name), verses]
    end

    def user
      @user ||= Db::User.find(user_id)
    end

    def bible
      @bible ||= Bible::Factory.new.from_config
    end
  end
end
