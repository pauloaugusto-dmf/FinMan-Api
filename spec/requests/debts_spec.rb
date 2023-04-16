require 'rails_helper'

RSpec.describe '/debts', type: :request do
  let(:user) { create :user }
  let(:tag) { create :tag }
  let(:account) { create :account, user_id: user.id }
  let(:debt) { create :debt, accounts_id: account.id, tags_id: tag.id }

  describe 'GET /index' do
    before do
      get '/api/debts', headers: authenticate_headers(user), as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns 200, OK' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show' do
    before do
      get "/api/debts/#{debt.id}", headers: authenticate_headers(user), as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns 200, OK' do
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post '/api/debts',
             params: {
               debt: {
                 name: 'nova compra',
                 description: 'compra feita',
                 value: 1500.50,
                 date: '03/11/2022',
                 is_installments: true,
                 installments: 5,
                 accounts_id: account.id,
                 tags: tag
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 201, created' do
        expect(response.status).to eq(201)
      end

      it 'creates a new Debt' do
        expect(Debt.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/debts',
             params: {
               debt: {
                 name: 'nova compra',
                 description: 'compra feita',
                 value: 'mil',
                 date: '03/11/2022',
                 is_installments: true,
                 installments: 5,
                 accounts_id: account.id,
                 tags: tag
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'does not renders a successful response' do
        expect(response).not_to be_successful
      end

      it 'returns 422, unprocessable entity' do
        expect(response.status).to eq(422)
      end

      it 'does not creates a new Debt' do
        expect(Debt.count).to eq(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        patch "/api/debts/#{debt.id}",
              params: {
                debt: {
                  name: 'novo nome'
                }
              }, headers: authenticate_headers(user), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'modify the name attribute' do
        expect(Debt.find(debt.id).name).to eq('novo nome')
      end
    end

    context 'with invalid parameters' do
      before do
        patch "/api/debts/#{debt.id}",
              params: {
                debt: {
                  name: nil
                }
              }, headers: authenticate_headers(user), as: :json
      end

      it 'does not renders a successful response' do
        expect(response).not_to be_successful
      end

      it 'returns 422, unprocessable entity' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete "/api/debts/#{debt.id}", headers: authenticate_headers(user), as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns 204, no content' do
      expect(response.status).to eq(204)
    end

    it 'destroys the requested account' do
      expect(Debt.count).to eq(0)
    end
  end
end
