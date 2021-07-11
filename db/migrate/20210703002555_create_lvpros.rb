class CreateLvpros < ActiveRecord::Migration[6.1]
  def change
    create_table :lvpros do |t|
      t.integer :lv
      t.integer :experience_point
      t.integer :profession
      t.integer :star
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
