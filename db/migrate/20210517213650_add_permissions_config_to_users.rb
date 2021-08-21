# frozen_string_literal: true

class AddPermissionsConfigToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :permissions_config, :text
  end
end
