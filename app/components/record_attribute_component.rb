# frozen_string_literal: true

class RecordAttributeComponent < AttributeWrapperComponent
  def initialize(record, attribute_name:)
    @record = record
    @attribute_name = attribute_name
    @urls = Routes.new

    attribute
      .with_icon(icon_name)
      .with_classes(bem)
      .with_label(attribute_name(record, @attribute_name))
      .without_label
  end

  private

  attr_reader :record

  def default_link
    attribute = record.send(@attribute_name)

    if attribute.present?
      return @urls.to(attribute)
    end

    super
  end

  def to_date(date)
    l(date.to_date)
  end
end
