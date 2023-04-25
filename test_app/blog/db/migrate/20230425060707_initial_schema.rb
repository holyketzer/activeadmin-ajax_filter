class InitialSchema < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
    end

    create_table :subcategories do |t|
      t.string :name, null: false
      t.references :category, null: false, index: true
    end

    create_table :items do |t|
      t.string :name, null: false
      t.references :subcategory, null: false, index: true
    end
  end
end
