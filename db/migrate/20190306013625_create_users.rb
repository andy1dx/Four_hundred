class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :username
      t.string :password
      t.integer :status

      t.timestamps
    end
  end
end
