class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.reference :users
      t.reference :articles

      t.timestamps
    end
  end
end
