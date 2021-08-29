# frozen_string_literal: true

class AddLabelFieldsToTimelineEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :timeline_entries, :text, :string
    add_column :timeline_entries, :text_properties, :json

    reversible do
      execute("UPDATE timeline_entries set text = title")
    end
  end
end
