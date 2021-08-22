# frozen_string_literal: true

class CreateTimelineEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :timeline_entries do |t|
      t.string :title
      t.text :explanation
      t.integer :year
      t.string :date_complement
      t.string :precision
      t.string :confirmed, default: false
      t.references :timeline, null: false

      t.timestamps
    end
  end
end
