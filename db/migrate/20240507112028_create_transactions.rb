class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.boolean :spent_in_foreign_country

      t.timestamps
    end
  end
end
