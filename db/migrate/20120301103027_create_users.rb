class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text   :location
      t.text   :image
      t.text   :investment_status
      t.text   :favorite_stocks

      t.timestamps
    end
  end
end
