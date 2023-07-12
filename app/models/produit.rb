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

    after_update do
        product = Stripe::Product.update(stripe_product_id, {name: name})
    end

    after_update  :create_and_assign_new_stripe_price, if: :saved_change_to_price?

    def create_and_assign_new_stripe_price 
        one_time_price = Stripe::Price.create(
            product: self.stripe_product_id, 
            unit_amount: self.price, 
            currency: 'eur')

        subscription_price = Stripe::Price.create(
            product: self.stripe_product_id, 
            recurring: {
                interval: 'month',
            },
            unit_amount: self.price/12, # Set the subscription price amount here
            currency: 'eur')

        update(stripe_price_id: one_time_price.id, stripe_subscription_price_id: subscription_price.id )
    end



    # tests sur subscriptions pour check si customer has one 

    def check_subscription(customer_id, product_id)
        subscriptions = Stripe::Subscription.list
      
        subscriptions_for_customer = subscriptions.select do |subscription|
          subscription.customer == customer_id && subscription.plan.product == product_id
        end
      
        if subscriptions_for_customer.present?
          valid_subscriptions = subscriptions_for_customer.select { |subscription| subscription_valid?(subscription) }
          valid_subscriptions.present?
        else
          false
        end
      end
      
      def subscription_valid?(subscription)
        return false unless subscription.status == 'active'
      
        invoice = Stripe::Invoice.retrieve(subscription.latest_invoice)
        return false unless invoice.status == 'paid'
      
        subscription.current_period_end > Time.now.to_i
      end
      
    
end
