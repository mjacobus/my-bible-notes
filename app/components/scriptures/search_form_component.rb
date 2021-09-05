# frozen_string_literal: true

module Scriptures
  class SearchFormComponent < ApplicationComponent
    has :params

    def search_params
      @search_params ||= SearchParams.new(params)
    end

    def clear_url
      urls.scriptures_path(profile_owner)
    end

    def has_filters?
      search_params.any?(:tags, :title)
    end
  end
end
