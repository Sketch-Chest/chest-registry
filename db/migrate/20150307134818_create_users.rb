class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :token
      t.datetime :deleted_at # paranoia

      t.timestamps null: false
    end
  end
end
