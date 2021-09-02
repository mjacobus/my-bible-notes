# frozen_string_literal: true

module Scriptures
  class FormPageComponent < PageComponent
    include Base::FormComponent

    record :form

    def book_input(form)
      select_input(form, :book, books)
    end

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new
        .under_profile(profile_owner).form_for(form.record)
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
