class CreateProfessions < ActiveRecord::Migration[6.1]
  def change
    create_table :professions do |t|
      t.integer :profession
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
