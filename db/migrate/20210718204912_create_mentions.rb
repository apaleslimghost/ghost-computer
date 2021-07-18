class CreateMentions < ActiveRecord::Migration[6.1]
  def change
    create_table :mentions do |t|
      t.references :post, null: false, foreign_key: true
      t.string :source
      t.jsonb :data

      t.timestamps
    end
  end
end
