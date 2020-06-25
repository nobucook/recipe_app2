class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :about
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recipes, [:user_id,:created_at]
  end
end
