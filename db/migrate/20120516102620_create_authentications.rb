class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :provider
      t.belongs_to :user

      t.timestamps
    end
    add_index :authentications, :user_id
  end
end
