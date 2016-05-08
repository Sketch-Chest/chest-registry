class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.references :user, null: false, index: true
      
      t.string :name, null: false
      t.string :identifier, null: false
      t.string :repository, null: false
      t.text :description
      t.text :readme
      t.string :homepage
      t.text :keywords
      t.text :author
      t.string :license
      t.integer :download_count, default: 0
      t.timestamps null: false
    end
    add_index :packages, :name, unique: true
    add_foreign_key :packages, :users
  end
end
