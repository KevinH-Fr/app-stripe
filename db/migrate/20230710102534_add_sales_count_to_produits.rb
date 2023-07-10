class AddSalesCountToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :sales_count, :integer, null: false, default: 0
  end
end
