# frozen_string_literal: true

class CreateDbScriptures < ActiveRecord::Migration[6.1]
  def change
    create_table :scriptures do |t|
      t.string :title
      t.string :book
      t.string :verses
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.bigint :parent_id

      t.timestamps
    end

    add_foreign_key(:scriptures, :scriptures, column: :parent_id)
  end
end
