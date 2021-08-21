# frozen_string_literal: true

class BreadcrumbComponent < ApplicationComponent
  attr_reader :items

  Item = Struct.new(:text, :url)

  def initialize
    @items = []
  end

  def render?
    items.any?
  end

  def add_item(text, url = nil)
    @items << Item.new(text, url)
  end

  def active_class_for_index(index)
    if (index + 1) == items.length
      'active'
    end
  end

  def aria_current(index)
    if (index + 1) == items.length
      'aria-current="page"'
    end
  end
end
