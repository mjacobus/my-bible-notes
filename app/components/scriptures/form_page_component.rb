# frozen_string_literal: true

class Scriptures::FormPageComponent < PageComponent
  has :scripture
  has :current_user
  has :owner

  def url
    if scripture.id
      return urls.to(scripture)
    end

    urls.scriptures_path(current_user)
  end

  private

  def setup
    breadcrumb.add(t('app.links.scriptures'), urls.scriptures_path(current_user))

    if scripture.id?
      breadcrumb.add(scripture.to_s, urls.to(scripture))
      breadcrumb.add(t('app.links.edit'))
      return
    end

    breadcrumb.add(t('app.links.new'))
  end
end
