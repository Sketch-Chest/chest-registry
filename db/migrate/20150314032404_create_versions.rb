class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :package, null: false, index: true
      t.string :tag, null: false

      t.timestamps
    end
    add_foreign_key :versions, :packages
  end
end
