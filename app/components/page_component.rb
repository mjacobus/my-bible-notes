# frozen_string_literal: true

class PageComponent < ApplicationComponent
  include MenuAwareComponent
  menu_type :list_options

  def flash
    FlashComponent.new
  end

  def pagination
    PaginationComponent.new(items)
  end

  def self.paginate(method)
    define_method :items do
      send(method)
    end
  end
end
