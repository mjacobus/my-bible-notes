# frozen_string_literal: true

class AttributeComponent < ApplicationComponent
  attr_reader :icon_name
  attr_reader :classes
  attr_reader :label
  attr_reader :link
  attr_reader :show_label
  attr_reader :container_tag
  attr_reader :container_options

  def initialize
    @classes = []
    @label = label
    @show_label = false
    @container_tag = :span
    @container_options = { class: class_names(bem) }
    wrap_with(container_tag, container_options)
  end

  def render?
    content.present?
  end

  def label_content
    if icon_name
      icon(icon_name) { label }
    else
      label
    end
  end

  def with_classes(classes)
    @container_options[:class] = class_names(@container_options[:class], class_names(classes))
    self
  end

  def with_label(label = nil)
    if label
      @label = I18n.t("app.attributes.#{label}", default: label)
    end

    @show_label = true
    @container_options[:title] = @label
    @container_options[:alt] = @label
    self
  end

  def without_label
    @show_label = false
    self
  end

  def with_icon(icon)
    @icon_name = icon
    self
  end

  def without_icon
    @icon_name = nil
    self
  end

  def with_link(link)
    @link = link
    self
  end

  def text_content
    if show_icon_in_text?
      return icon(icon_name, class: 'icon-soft') { content }
    end

    content
  end

  def wrap_with(tag, options = {})
    @container_tag = tag
    classes = class_names(options[:class], @container_options[:class])
    @container_options.merge!(options)
    @container_options[:class] = classes
    self
  end

  private

  def show_icon_in_text?
    icon_name && !label
  end
end
