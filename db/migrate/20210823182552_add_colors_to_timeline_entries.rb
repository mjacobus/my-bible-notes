# frozen_string_literal: true

class AddColorsToTimelineEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :timeline_entries, :color, :string
  end
end
