# frozen_string_literal: true

module Scriptures
  class FormPageComponent < BaseFormPageComponent
    record :scripture

    def book_input(form)
      select_input(form, :book, books)
    end

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(owner).form_for(scripture)
    end

    def books
      Bible::Factory.new.from_config.map do |book|
        [book.localized_name, book.slug]
      end
    end

    def index_link_name
      t('app.links.my_scriptures')
    end
  end
end
