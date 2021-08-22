# frozen_string_literal: true

class CreateTimelines < ActiveRecord::Migration[6.1]
  def change
    create_table :timelines do |t|
      t.string :name
      t.string :slug, index: { unique: true }, null: false
      t.text :description
      t.boolean :public, default: false
      t.references :user

      t.timestamps
    end
  end
end
