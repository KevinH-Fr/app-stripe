class Produit < ApplicationRecord
    validates :name, :price, presence: true

    monetize :price, as: :price_cent

    def to_s
        name
    end

    after_create do
        product = Stripe::Product.create(name: name)
      
        one_time_price = Stripe::Price.create(product: product, unit_amount: self.price, currency: 'eur')
      
        subscription_price = Stripe::Price.create({
          product: product,
          recurring: {
            interval: 'month',
          },
          unit_amount: self.price/12, # Set the subscription price amount here
          currency: 'eur',
        })
      
        update(stripe_product_id: product.id, stripe_price_id: one_time_price.id, stripe_subscription_price_id: subscription_price.id)
      end
      
      

    #after_update do

    #   product = Stripe::Product.update(stripe_product_id, { name: self.name })
        # Créer un nouveau tarif avec le nouveau montant
    #    new_price = Stripe::Price.create(
    #        product: stripe_product_id,
    #        unit_amount: self.price,
    #        currency: 'eur'
    #    )
    
        # Mettre à jour le produit avec le nouvel identifiant de tarif
    #    Stripe::Product.update(stripe_product_id, {
    #        metadata: { stripe_price_id: new_price.id }
    #    })
    
        # Désactiver l'ancien tarif
    #    Stripe::Price.update(stripe_price_id, active: false) if stripe_price_id.present?
    
        # Update the product's stripe_price_id with the new price ID
    #    update(stripe_price_id: new_price.id)

    #end
      
end
