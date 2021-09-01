# frozen_string_literal: true

class Scriptures::FormPageComponent < BaseFormPageComponent
  record :scripture

  def book_input(form)
    select_input(form, :book, books)
  end

  private

  def books
    Bible::Factory.new.from_config.map do |book|
      [book.localized_name, book.slug]
    end
  end

  def index_link_name
    t('app.links.my_scriptures')
  end
end
