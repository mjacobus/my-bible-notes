# frozen_string_literal: true

class BaseFinder
  delegate :each, to: :scope
  delegate :pluck, to: :scope

  def initialize(user, scope: default_scope)
    @user = user
    @scope = scope
  end

  private

  def with_scope(scope)
    self.class.new(@user, scope: scope)
  end

  attr_reader :scope
  attr_reader :user
end
