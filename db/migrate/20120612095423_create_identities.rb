class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :email
      t.string :password_digest
      t.string :password_reset_token

      t.timestamps
    end
  end
end
