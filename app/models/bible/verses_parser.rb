# frozen_string_literal: true

module Bible
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/ClassLength
  class VersesParser
    def initialize(available_verses)
      @chapters = available_verses
    end

    def parse(string)
      result = {}
      split(string).each do |excerpt|
        parsed = parse_scripture(excerpt)
        Array.wrap(parsed).each do |p|
          result[p[:chapter]] = p[:verses]
        end
      end

      inspect_result(result)
      result
    end

    def split(string)
      string.to_s.gsub(/\s+/, '').split(';')
    end

    private

    def inspect_result(result)
      result.each do |chapter, _verses|
        assert_chapter(chapter)
      end
    end

    def assert_chapter(chapter)
      if @chapters[chapter].blank?
        raise Errors::InvalidChapterError, chapter
      end
    end

    def assert_verse(verse, chapter:)
      assert_chapter(chapter)
      if verse > last_chapter_verse(chapter)
        raise Errors::InvalidVerseError.new(verse, chapter: chapter)
      end
    end

    def parse_scripture(excerpt)
      if @chapters.keys.length == 1 && !excerpt.match(':')
        excerpt = "1:#{excerpt}"
      end

      excerpts = split(normalize_excerpt(excerpt))

      excerpts.map { |e| parse_excerpt(e) }
    end

    def parse_excerpt(excerpt)
      parts = excerpt.split(':')

      chapter = parts[0].to_i
      excerpt = parts[1]
      csv = excerpt.to_s.split(',')
      verses = []
      csv.each do |values|
        range = values.split('-')
        first = range[0].to_i
        assert_verse(first, chapter: chapter)

        verses << if range.length == 2
                    last = range[1].to_i
                    assert_verse(last, chapter: chapter)
                    (first..last).to_a
                  else
                    first
                  end
      end

      if csv.empty?
        verses << chapter_verses(chapter)
      end

      { chapter: chapter, verses: verses.flatten }
    end

    # I.E 2-4 - Multi chapter range
    # I.E 2:10-4:3 Multi chapter with verse range
    # I.E 2:4-14 - Multi verse range
    def normalize_excerpt(excerpt)
      if /^\d+-\d+$/.match?(excerpt)
        return normalize_multi_chapter_excerpt(excerpt)
      end

      if /^\d+:\d+-\d+:\d+$/.match?(excerpt)
        return normalize_multi_chapter_with_verses_excerpt(excerpt)
      end

      excerpt
    end

    def normalize_multi_chapter_excerpt(excerpt)
      chapters = excerpt.split('-').map(&:to_i)
      chapters = (chapters.first..chapters.last).to_a
      chapters.map do |chapter|
        assert_chapter(chapter)
        "#{chapter}:1-#{chapter_verses(chapter).last}"
      end.join(';')
    end

    def normalize_multi_chapter_with_verses_excerpt(excerpt)
      ranges = excerpt.split('-').map { |p| p.split(':').map(&:to_i) }
      first_chapter = ranges.first.first
      first_verse = ranges.first.last
      last_chapter = ranges.last.first
      last_verse = ranges.last.last

      (first_chapter..last_chapter).to_a.map do |chapter|
        if chapter == first_chapter
          next "#{chapter}:#{first_verse}-#{last_chapter_verse(chapter)}"
        end
        if chapter == last_chapter
          next "#{chapter}:1-#{last_verse}"
        end

        "#{chapter}:1-#{last_chapter_verse(chapter)}"
      end.join(';')
    end

    def chapter_verses(chapter, from: 1)
      (from..last_chapter_verse(chapter)).to_a
    end

    def last_chapter_verse(chapter)
      @chapters[chapter]
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/ClassLength
end
