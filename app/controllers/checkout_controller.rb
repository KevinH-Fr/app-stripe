class CheckoutController < ApplicationController
  def create      
        
    product = Produit.find(params[:id])
    
    session = Stripe::Checkout::Session.create({
      line_items: [{
        #price: 'price_1NQBM4AGIT8oyD13qP5IVsxd',
        price: product.stripe_price_id,
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,  # Replace with your actual success URL
      cancel_url: root_url,    # Replace with your actual cancel URL
      })


     redirect_to session.url, allow_other_host: true, status: 303

  end
end
