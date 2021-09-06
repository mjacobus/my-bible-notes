# frozen_string_literal: true

class FixTagsUk < ActiveRecord::Migration[6.1]
  def change
    remove_index :tags, %i[name type], unique: true
    add_index :tags, %i[name type user_id], unique: true
  end
end
