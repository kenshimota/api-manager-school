class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.string :letter

      t.timestamps
    end
    add_index :sections, :letter, unique: true
  end
end
