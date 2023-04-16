class CreateCheckingAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :checking_accounts do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :account_number
      t.decimal :monthly_fee, null: false, default: 0
      t.string :agency

      t.timestamps
    end
  end
end
