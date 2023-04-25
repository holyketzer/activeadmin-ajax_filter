class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.references :subcategory, null: false, index: true
    end

    create_join_table :items, :tags do |t|
      t.index [:item_id, :tag_id]
      t.index [:tag_id, :item_id]
    end
  end
end
