class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.string     :name,            null: false
      t.string     :description
      t.decimal    :value,           null: false, default: 0
      t.datetime   :date
      t.boolean    :continuous,      null: false
      t.references :tags,            foreign_key: true
      t.references :accounts,        foreign_key: true

      t.timestamps
    end
  end
end
