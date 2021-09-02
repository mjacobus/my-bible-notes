# frozen_string_literal: true

class AddBookNumberToScriptures < ActiveRecord::Migration[6.1]
  def change
    add_column :scriptures, :book_number, :integer, default: 0
  end
end
