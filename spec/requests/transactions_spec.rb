require 'rails_helper'

RSpec.describe '/transactions', type: :request do
  let(:user) { create :user }
  let(:account) { create :account, user_id: user.id }
  let(:transaction) { create :transaction, account_id: account.id }

  describe 'GET /index' do
    before do
      get "/api/accounts/#{account.id}/transactions", headers: authenticate_headers(user),
                                                      as: :json
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
      get "/api/accounts/#{account.id}/transactions/#{transaction.id}",
          headers: authenticate_headers(user), as: :json
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
        post "/api/accounts/#{account.id}/transactions",
             params: {
               transaction: {
                 value: 1500.50
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 201, created' do
        expect(response.status).to eq(201)
      end

      it 'creates a new Transaction' do
        expect(Transaction.count).to eq(1)
      end
    end

    context 'with a transaction of 200 in an account' do
      before do
        post "/api/accounts/#{account.id}/transactions",
             params: {
               transaction: {
                 value: 200
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'the account must have a balance of 200' do
        ac = Account.find(account.id)
        expect(ac.balance.to_f).to eq(200)
      end
    end

    context 'With a transaction of 200 on an account with a balance of 500' do
      before do
        account.balance = 500
        account.save
        post "/api/accounts/#{account.id}/transactions",
             params: {
               transaction: {
                 value: 200
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'the account must have a balance of 700' do
        ac = Account.find(account.id)
        expect(ac.balance.to_f).to eq(700)
      end
    end

    context 'With a transaction of -200 on an account with a balance of 500' do
      before do
        account.balance = 500
        account.save
        post "/api/accounts/#{account.id}/transactions",
             params: {
               transaction: {
                 value: -200
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'the account must have a balance of -300' do
        ac = Account.find(account.id)
        expect(ac.balance.to_f).to eq(300)
      end
    end

    context 'with invalid parameters' do
      context 'with invalid parameters' do
        before do
          post "/api/accounts/#{account.id}/transactions",
               params: {
                 transaction: {
                   value: 'A'
                 }
               }, headers: authenticate_headers(user), as: :json
        end

        it 'does not renders a successful response' do
          expect(response).not_to be_successful
        end

        it 'returns 422, unprocessable entity' do
          expect(response.status).to eq(422)
        end

        it 'does not creates a new Transaction' do
          expect(Transaction.count).to eq(0)
        end
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        patch "/api/accounts/#{account.id}/transactions/#{transaction.id}",
              params: {
                transaction: {
                  value: 250
                }
              }, headers: authenticate_headers(user), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'modify the value attribute' do
        expect(Transaction.find(transaction.id).value).to eq(250)
      end
    end

    context 'with invalid parameters' do
      before do
        patch "/api/accounts/#{account.id}/transactions/#{transaction.id}",
              params: {
                transaction: {
                  value: 'A'
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
      delete "/api/accounts/#{account.id}/transactions/#{transaction.id}",
             headers: authenticate_headers(user), as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns 204, no content' do
      expect(response.status).to eq(204)
    end

    it 'destroys the requested transaction' do
      expect(Transaction.count).to eq(0)
    end
  end
end
