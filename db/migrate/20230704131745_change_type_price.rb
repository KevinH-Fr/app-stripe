class ChangeTypePrice < ActiveRecord::Migration[7.0]
  def change
    change_column :produits, :price, :integer
  end
end
