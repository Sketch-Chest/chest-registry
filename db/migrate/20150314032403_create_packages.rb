class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.references :user, null: false, index: true
      t.text :description
      t.text :readme
      t.text :readme_html
      t.string :homepage
      t.string :repository_type
      t.string :repository_url
      t.string :keywords
      t.text :authors
      t.string :license
      t.integer :download_count, default: 0

      t.timestamps null: false
    end
    add_index :packages, :name, unique: true
    add_foreign_key :packages, :users
  end
end
