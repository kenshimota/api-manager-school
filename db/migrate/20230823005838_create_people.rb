class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.bigint :identity_document, null: false, index: { unique: true }
      t.integer :phone_code
      t.bigint :phone_number
      t.string :address
      t.timestamps
    end
  end
end
