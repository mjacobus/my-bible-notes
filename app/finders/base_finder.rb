# frozen_string_literal: true

class BaseFinder
  delegate :each, to: :scope
  delegate :pluck, to: :scope

  def initialize(user, scope: default_scope)
    @user = user
    @scope = scope
  end

  def page(page)
    with_scope(scope.page(page))
  end

  def per(per_page)
    with_scope(scope.per(per_page))
  end

  def total_pages
    scope.total_pages
  end

  def current_page
    scope.current_page
  end

  def new

  end

  def limit_value
    scope.limit_value
  end

  def find(id)
    scope.find(id)
  end

  private

  def with_scope(scope)
    self.class.new(@user, scope: scope)
  end

  attr_reader :scope
  attr_reader :user
end
