class CreateSubscription < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.integer :frequency
      t.boolean :status
      t.references :customer, foreign_key: true
      t.references :tea, foreign_key: true

      t.timestamps
    end
  end
end
