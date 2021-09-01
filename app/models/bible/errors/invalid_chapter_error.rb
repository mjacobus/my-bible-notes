# frozen_string_literal: true

module Bible
  module Errors
    class InvalidChapterError < ArgumentError
      attr_reader :chapter

      def initialize(chapter)
        @chapter = chapter
        super("Invalid chapter #{chapter}")
      end
    end
  end
end
