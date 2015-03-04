class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.references :user, index: true
      t.text :description
      t.text :readme
      t.string :tarball_url
      t.datetime :deleted_at, default: nil
      t.timestamps null: false
    end
    add_index :packages, :name, unique: true
    add_foreign_key :packages, :users
  end
end
