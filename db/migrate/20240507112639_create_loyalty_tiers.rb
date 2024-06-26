class CreateLoyaltyTiers < ActiveRecord::Migration[7.1]
  def change
    create_table :loyalty_tiers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :points
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
