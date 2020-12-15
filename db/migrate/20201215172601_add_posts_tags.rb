class AddPostsTags < ActiveRecord::Migration[6.1]
  def change
    create_table :posts_tags, id: false do |t|
      t.belongs_to :post
      t.belongs_to :tag
    end
  end
end
