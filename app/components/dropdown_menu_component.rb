# frozen_string_literal: true

class DropdownMenuComponent < ApplicationComponent
  renders_many :items
  attr_reader :title
  attr_reader :icon_name
  attr_reader :type

  def initialize(title: '', classes: [], icon: 'three-dots', type: nil)
    @title = title
    @classes = Array.wrap(classes)
    @icon_name = icon
    @type = type
  end

  def classes
    @classes.join(' ')
  end

  def container_classes
    if @pull
      "pull-#{@pull}"
    end
  end
end
