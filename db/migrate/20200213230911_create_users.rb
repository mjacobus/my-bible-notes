# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :avatar
      t.string :oauth_provider
      t.string :oauth_uid
      t.boolean :master, default: false
      t.boolean :enabled, default: false

      t.timestamps
    end

    add_index(:users, %i[oauth_provider oauth_uid], unique: true)
  end
end
