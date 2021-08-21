# frozen_string_literal: true

class NotesAttributeComponent < AttributeWrapperComponent
  def initialize(value)
    @value = value
    with_label('notes')
    without_label
  end

  def icon_name
    'pencil'
  end
end
