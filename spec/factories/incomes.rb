FactoryBot.define do
  factory :income do
    name { 'Salario' }
    description { 'Salario recebido' }
    value { 100 }
    date { '03/11/2022' }
    continuous { true }
    association :account_id, strategy: :build
    association :tags_id, strategy: :build
  end
end
