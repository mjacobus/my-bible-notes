# frozen_string_literal: true

class ScriptureFinder < BaseFinder
  def search(params = {})
    params = SearchParams.new(params)
    query = scope

    params.if(:title) do |title|
      query = query.where('title ILIKE ?', "%#{title}%")
    end

    params.if(:tags) do |slugs|
      tags = slugs.split(',').map(&:strip)
      query = query.joins(:tags).where(tags: { slug: tags })
    end

    with_scope(query)
  end

  def eager_load
    with_scope(scope.includes(%i[tags related_scriptures]))
  end

  def under_profile(user_profile)
    with_scope(scope.where(user_id: user_profile.id))
  end

  def parents
    with_scope(scope.parents)
  end

  private

  def default_scope
    @scope ||= Db::Scripture.ordered
  end
end
