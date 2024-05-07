class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reward_type
      t.integer :dicount_percentage
      t.text :description

      t.timestamps
    end
  end
end
