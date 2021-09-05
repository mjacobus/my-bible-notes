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

    def selected_tags
      @selected_tags ||= profile_owner.tags.scripture.where(slug: tag_slugs)
    end

    def tag_slugs
      search_params[:tags].to_s.split(',').map(&:strip)
    end

    def selected_tags_message
      t('app.messages.selected_tags', tag_names: selected_tags.map(&:name).join(', '))
    end
  end
end
