class AddDefaultToLvpro < ActiveRecord::Migration[6.1]
  def up
    change_column :lvpros,:lv,:integer,:default=>1
    change_column :lvpros,:profession,:integer,:default=>0
    change_column :lvpros,:star,:integer,:default=>0
  end

  def dwon
    change_column :lvpros,:lv,:integer
    change_column :lvpros,:profession,:integer
    change_column :lvpros,:star,:integer
  end
end
