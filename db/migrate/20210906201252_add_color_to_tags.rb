# frozen_string_literal: true

class AddColorToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :color, :string

    reversible do
      execute('SELECT id, name FROM tags WHERE color IS NULL').each do |result|
        color = NameBasedColor.new(result['name'])
        id = result['id']

        sql = <<~SQL.squish
          UPDATE tags#{' '}
          SET color = '#{color}'#{' '}
          WHERE id = #{id}
        SQL
        execute(sql)
      end
    end
  end
end
