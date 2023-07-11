class CheckoutController < ApplicationController
  def create      
        
    product = Produit.find(params[:id])
    
    session = Stripe::Checkout::Session.create({
      line_items: [{
        price: product.stripe_price_id,
        quantity: 1,
      }],
      mode: 'payment',
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}", 
      cancel_url: cancel_url,   
      })

     redirect_to session.url, allow_other_host: true, status: 303

  end

  def success
  end

  def cancel
  end

end
