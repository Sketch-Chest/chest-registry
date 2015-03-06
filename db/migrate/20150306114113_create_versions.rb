class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version, null: false
      t.attachment :archive, null: false
      t.references :package, null: false, index: true
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_foreign_key :versions, :packages
  end
end
