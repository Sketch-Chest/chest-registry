class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.references :user, index: true
      t.text :description
      t.string :repository

      t.timestamps null: false
    end
    add_index :packages, :name, unique: true
    add_foreign_key :packages, :users
  end
end
