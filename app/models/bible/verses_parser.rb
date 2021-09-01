# frozen_string_literal: true

module Bible
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  class VersesParser
    def initialize(available_verses)
      @available_verses = available_verses
    end

    def parse(string)
      result = {}
      string.to_s.gsub(/\s+/, '').split(';').each do |part|
        if @available_verses.keys.length == 1 && !part.match(':')
          part = "1:#{part}"
        end
        parsed = parse_part(part)
        result[parsed[:chapter]] = parsed[:verses]
      end
      result
    end

    private

    def parse_part(string)
      parts = string.split(':')

      chapter = parts[0].to_i
      string = parts[1]
      csv = string.to_s.split(',')
      collected_verses = []
      csv.each do |values|
        range = values.split('-')
        collected_verses << if range.length == 2
                              (range[0].to_i..range[1].to_i).to_a
                            else
                              range.first.to_i
                            end
      end

      if csv.empty?
        collected_verses << (1..@available_verses[chapter]).to_a
      end

      { chapter: chapter, verses: collected_verses.flatten }
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
