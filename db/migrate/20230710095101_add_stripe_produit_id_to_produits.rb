class AddStripeProduitIdToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :stripe_product_id, :string
  end
end
