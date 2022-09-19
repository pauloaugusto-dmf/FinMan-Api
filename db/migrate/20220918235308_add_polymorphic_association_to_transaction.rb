class AddPolymorphicAssociationToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :transactions, :typeable, polymorphic: true, index: true
  end
end
