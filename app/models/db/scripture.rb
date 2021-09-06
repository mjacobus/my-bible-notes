# frozen_string_literal: true

class Db::Scripture < ApplicationRecord
  belongs_to :user
  belongs_to :parent_scripture,
             class_name: 'Scripture',
             foreign_key: :parent_id,
             inverse_of: :related_scriptures,
             optional: true
  has_many :related_scriptures,
           -> { order(:sequence_number) },
           class_name: 'Scripture',
           foreign_key: 'parent_id',
           dependent: :restrict_with_exception,
           inverse_of: :parent_scripture
  has_and_belongs_to_many :tags

  scope :ordered, -> { order(:book_number, :first_chapter, :first_verse) }
  scope :parents, -> { where(parent_id: nil) }
  scope :with_dependencies, -> { includes(%i[tags related_scriptures]) }

  delegate :username, to: :user
  max_paginates_per 200

  def to_s
    "#{book_instance.localized_name} #{verses}"
  end

  def scripture_and_title
    "#{self} - #{title}"
  end

  def book=(book)
    @book_instance = nil
    super(book)
    set_book_number
  end

  def verses=(value)
    super(value)
    parts = value.to_s.split(':')
    self.first_chapter = parts[0].to_i
    self.first_verse = parts[1].to_i
  end

  def book_instance
    @book_instance ||= self.class.bible.find(book)
  end

  def self.bible
    @bible = Bible::Factory.new.from_config
  end

  def self.search(params = {})
    params = SearchParams.new(params)
    query = all

    params.if(:title) do |title|
      query = query.where('title ILIKE ?', "%#{title}%")
    end

    params.if(:tags) do |slugs|
      tags = slugs.split(',').map(&:strip)
      query = query.joins(:tags).where(tags: { slug: tags })
    end

    query
  end

  private

  def set_book_number
    if book_instance
      self.book_number = book_instance.number
    end
  end
end
