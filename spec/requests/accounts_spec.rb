require 'rails_helper'

RSpec.describe '/accounts', type: :request do
  let(:user) { create :user }
  let(:account) { create :account, user_id: user.id }

  describe 'GET /index' do
    before do
      get '/api/accounts', headers: authenticate_headers(user), as: :json
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
      get "/api/accounts/#{account.id}", headers: authenticate_headers(user), as: :json
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
        post '/api/accounts',
             params: {
               account: {
                 name: 'nova conta',
                 balance: 1500.50
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 201, created' do
        expect(response.status).to eq(201)
      end

      it 'creates a new Account' do
        expect(Account.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/accounts',
             params: {
               account: {
                 name: 'nova conta',
                 balance: 'dois mil reais'
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'does not renders a successful response' do
        expect(response).not_to be_successful
      end

      it 'returns 422, unprocessable entity' do
        expect(response.status).to eq(422)
      end

      it 'does not creates a new Account' do
        expect(Account.count).to eq(0)
      end
    end

    context 'With initial value of 500' do
      before do
        post '/api/accounts',
             params: {
               account: {
                 name: 'nova conta',
                 balance: 500
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'must have a balance of 500' do
        balance = Account.all.last.balance
        expect(balance).to eq(500.0)
      end

      it 'create a new Transactions' do
        expect(Transaction.count).to eq(1)
      end
    end

    context 'With initial value of -500' do
      before do
        post '/api/accounts',
             params: {
               account: {
                 name: 'nova conta',
                 balance: -500
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'must have a balance of -500' do
        balance = Account.all.last.balance
        expect(balance).to eq(-500.0)
      end

      it 'create a new Transaction' do
        expect(Transaction.count).to eq(1)
      end
    end

    context 'With initial value of 0' do
      before do
        post '/api/accounts',
             params: {
               account: {
                 name: 'nova conta',
                 balance: 0
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'must have a balance of 0' do
        balance = Account.all.last.balance
        expect(balance).to eq(0)
      end

      it 'does not create a new Transactions' do
        expect(Transaction.count).to eq(0)
      end
    end

    context 'No initial value' do
      before do
        post '/api/accounts',
             params: {
               account: {
                 name: 'nova conta'
               }
             }, headers: authenticate_headers(user), as: :json
      end

      it 'must have a balance of 0' do
        balance = Account.all.last.balance
        expect(balance).to eq(0)
      end

      it 'does not create a new Transactions' do
        expect(Transaction.count).to eq(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        patch "/api/accounts/#{account.id}",
              params: {
                account: {
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
        expect(Account.find(account.id).name).to eq('novo nome')
      end
    end

    context 'with invalid parameters' do
      before do
        patch "/api/accounts/#{account.id}",
              params: {
                account: {
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
      delete "/api/accounts/#{account.id}", headers: authenticate_headers(user), as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns 204, no content' do
      expect(response.status).to eq(204)
    end

    it 'destroys the requested account' do
      expect(Account.count).to eq(0)
    end
  end
end
