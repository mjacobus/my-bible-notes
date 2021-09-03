# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :slug, index: true, null: false
      t.string :type
      t.references :user

      t.timestamps
    end

    add_index :tags, %i[name type], unique: true
  end
end
