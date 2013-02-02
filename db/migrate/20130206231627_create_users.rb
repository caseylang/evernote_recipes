class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, null: false, default: 'evernote'
      t.integer :uid, null: false, unique: true
      t.string :username, null: false
      t.string :name
      t.string :web_api_url, null: false

      t.timestamps
    end

    add_index :users, [:uid, :username]
  end
end
