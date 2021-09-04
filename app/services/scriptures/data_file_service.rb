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
      import_tags
    end

    private

    def import_tags
      data[:scriptures].each do |scripture|
        import_scripture(scripture)
        Array.wrap(scripture[:tags]).each do |tag|
          Db::ScriptureTag.find_or_create_by_name(tag, user_id: user_id)
        end
      end
    end

    def import_scripture(scripture, parent_id: nil)
      book = find_by_title(scripture[:title])

      Scriptures::Form.new do |form|
        form.title = scripture[:description]
        form.tags_string = Array.wrap(scripture[:tags].join(','))
        unless form.save
          raise "Cannot save #{scripture.to_yaml}"
        end
      end
    end

    def find_by_title(title)
      title
    end
  end
end
