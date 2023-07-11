class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subscription_status
      t.datetime :subscription_end_date
      t.datetime :subscription_start_date

      t.timestamps
    end
  end
end
