# frozen_string_literal: true

module Bible
  module Errors
    class InvalidVerseError < ArgumentError
      attr_reader :chapter
      attr_reader :verse

      def initialize(verse, chapter:)
        @verse = verse
        @chapter = chapter
        super("Invalid verse #{chapter}:#{verse}")
      end
    end
  end
end
