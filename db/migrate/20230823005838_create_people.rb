class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.integer :document_identification, null: false, index: { unique: true }
      t.string :address
      t.timestamps
    end

    # add_index :people, [:document_identification], unique: true
  end
end
