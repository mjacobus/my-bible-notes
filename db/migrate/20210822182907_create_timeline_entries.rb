# frozen_string_literal: true

class CreateTimelineEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :timeline_entries do |t|
      t.string :title
      t.text :explanation

      # from
      t.integer :from_year
      t.string :from_date_complement
      t.string :from_precision

      # to
      t.integer :to_year
      t.string :to_date_complement
      t.string :to_precision

      t.boolean :confirmed, default: false
      t.references :timeline, null: false

      t.timestamps
    end
  end
end
