class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :package, null: false, index: true
      t.string :version, null: false
      t.attachment :archive, null: false # paperclip

      t.timestamps null: false
    end
    add_foreign_key :versions, :packages
  end
end
