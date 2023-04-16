class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name,      null: false
      t.decimal :balance,  null: false, default: 0
      t.boolean :active,  null: false, default: false
      t.references :user,  foreign_key: true

      t.timestamps
    end
  end
end
