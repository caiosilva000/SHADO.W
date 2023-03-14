class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :card_number
      t.string :cvc
      t.string :expiration_month
      t.string :expiration_year
      t.float :total_price
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
