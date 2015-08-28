class CreateArticles < ActiveRecord::Migration
  def up 
    create_table :articles do |t|
      t.string :headline
    #  t.string :description
   #   t.string :img
      t.string :text
      t.integer :rating
    end
  end
  def down
    drop_table :articles
  end
end
