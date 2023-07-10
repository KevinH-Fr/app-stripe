class CreateProduits < ActiveRecord::Migration[7.0]
  def change
    create_table :produits do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
