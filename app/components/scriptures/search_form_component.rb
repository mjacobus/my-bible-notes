# frozen_string_literal: true

module Scriptures
  class SearchFormComponent < ApplicationComponent
    has :params

    def search_params
      @search_params ||= SearchParams.new(params)
    end

    def scriptures_path
      urls.scriptures_path(profile_owner)
    end

    def selected_tags
      @selected_tags ||= profile_owner.tags.scripture.where(slug: tag_slugs)
    end

    def tag_slugs
      search_params[:tags].to_s.split(',').map(&:strip)
    end

    def title_input(form)
      form.text_field(:title, input_options.merge(value: search_params[:title]))
    end

    private

    def input_options
      { class: 'form-control' }
    end
  end
end
