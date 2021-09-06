# frozen_string_literal: true

class AddOrderFieldsToScriptures < ActiveRecord::Migration[6.1]
  def change
    add_column :scriptures, :first_chapter, :integer
    add_column :scriptures, :first_verse, :integer

    reversible do
      execute('SELECT id, verses FROM scriptures').each do |result|
        parts = result['verses'].split(':')
        chapter = parts[0].to_i
        verse = parts[1].to_i
        id = result['id']
        sql = <<~SQL.squish
          UPDATE scriptures#{' '}
          SET first_chapter = '#{chapter}', first_verse = '#{verse}'#{' '}
          WHERE id = #{id}
        SQL
        execute(sql)
      end
    end
  end
end
