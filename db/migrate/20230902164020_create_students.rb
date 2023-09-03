class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.references :person, null: false, foreign_key: true, index: { unique: true }
      t.date :birthday
      t.timestamps
    end
  end
end
