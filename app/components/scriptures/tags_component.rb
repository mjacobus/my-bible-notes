# frozen_string_literal: true

class Scriptures::TagsComponent < ApplicationComponent
  has :tags

  def tag_url(tag)
    urls.scriptures_path(profile_owner, tags: tag.slug)
  end
end
