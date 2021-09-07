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

  def eager_load_dependencies
    with_scope(includes(%i[tags related_scriptures]))
  end

  private

  def default_scope
    @scope ||= Db::Scripture.ordered
  end
end
