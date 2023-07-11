class AddStripeSubscriptionPriceIdToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :stripe_subscription_price_id, :string
  end
end
