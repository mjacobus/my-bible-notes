# frozen_string_literal: true

class CreateScripturesTags < ActiveRecord::Migration[6.1]
  def change
    create_join_table :scriptures, :tags
  end
end
