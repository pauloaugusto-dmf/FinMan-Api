FactoryBot.define do
  factory :debt do
    name { 'Nova Compra' }
    description { 'Compra feita' }
    value { 100 }
    date { '03/11/2022' }
    is_installments { True }
    installments { 5 }
    association :account_id, strategy: :build
    association :tags_id, strategy: :build
  end
end
