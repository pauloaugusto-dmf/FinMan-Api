class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :value,  null: false
      t.references :account,  foreign_key: true

      t.timestamps
    end
  end
end
