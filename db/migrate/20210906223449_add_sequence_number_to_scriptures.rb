# frozen_string_literal: true

class AddSequenceNumberToScriptures < ActiveRecord::Migration[6.1]
  def change
    add_column :scriptures, :sequence_number, :integer, default: 0
  end
end
