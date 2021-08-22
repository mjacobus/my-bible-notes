# frozen_string_literal: true

class CreateTimelines < ActiveRecord::Migration[6.1]
  def change
    create_table :timelines do |t|
      t.string :name
      t.string :slug, null: false
      t.text :description
      t.boolean :public, default: false
      t.references :user

      t.timestamps
    end

    add_index :timelines, %i[slug user_id], unique: true
  end
end
