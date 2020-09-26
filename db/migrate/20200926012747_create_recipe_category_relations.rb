class CreateRecipeCategoryRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_category_relations do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recipe_category_relations, [:recipe_id, :category_id], :unique =>  true
  end
end
