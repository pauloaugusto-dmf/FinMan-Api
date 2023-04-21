require 'rails_helper'

RSpec.describe '/checking_accounts', type: :request do
  let(:user_one) { create :user }
  let(:user_two) { create :user }
  let(:account_one) { create :account, user: user_one }
  let(:account_two) { create :account, user: user_two }
  let(:checking_account_one) { create :checking_account, account: account_one }
  let(:checking_account_two) { create :checking_account, account: account_two }

  describe 'GET /index' do
    it 'renders a successful response' do
      get '/api/checking_accounts', headers: authenticate_headers(user_one), as: :json

      expect(response).to be_successful
    end

    it "returns only the user's checking accounts" do
      checking_account_one
      checking_account_two
      get '/api/checking_accounts', headers: authenticate_headers(user_one), as: :json

      account_ids = JSON.parse(response.body)['items'].map { |h| h['id'] }

      expect(account_ids.include?(checking_account_one.id)).to be_truthy
      expect(account_ids.include?(checking_account_two.id)).to be_falsey
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get "/api/checking_accounts/#{checking_account_one.id}", headers: authenticate_headers(user_one),
                                                               as: :json

      expect(response).to be_successful
    end

    it 'returns unauthorized if the user is not the owner of the account' do
      get "/api/checking_accounts/#{checking_account_two.id}", headers: authenticate_headers(user_one),
                                                               as: :json

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:unauthorized)
      expect(parsed_body['error']).to eq('Unauthorized')
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post '/api/checking_accounts/',
             params: {
               checking_account: {
                 account_number: '2312',
                 agency: '23424',
                 monthly_fee: 7.50,
                 account_attributes: {
                   active: true,
                   balance: 100.00,
                   name: 'nubank'
                 }
               }
             }, headers: authenticate_headers(user_one), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'creates a new CheckingAccount and new Account' do
        expect(Account.count).to eq(1)
        expect(CheckingAccount.count).to eq(1)
      end

      it 'renders a JSON response with the new checking_account' do
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/checking_accounts/',
             params: {
               checking_account: {
                 account_number: '2312',
                 agency: '23424',
                 monthly_fee: 7.50,
                 account_attributes: {
                   active: true,
                   balance: '100.00',
                   name: 'nubank'
                 }
               }
             }, headers: authenticate_headers(user_one), as: :json
      end

      it 'does not create a new CheckingAccount' do
        expect(Account.count).to eq(0)
        expect(CheckingAccount.count).to eq(0)
      end

      it 'renders a JSON response with errors for the new checking_account' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'after creating a current account when trying to create a new one with the same agency value' do
      it 'must be valid if the account numbers are different' do
        post '/api/checking_accounts/',
             params: {
               checking_account: {
                 account_number: checking_account_one.account_number,
                 agency: '54321',
                 monthly_fee: 7.50,
                 account_attributes: {
                   active: true,
                   balance: 100.00,
                   name: 'nubank'
                 }
               }
             }, headers: authenticate_headers(user_one), as: :json

        expect(response).to have_http_status(:created)
      end

      it 'must not be valid if the account numbers are the same' do
        post '/api/checking_accounts/',
             params: {
               checking_account: {
                 account_number: checking_account_one.account_number,
                 agency: checking_account_one.agency,
                 monthly_fee: 7.50,
                 account_attributes: {
                   active: true,
                   balance: 100.00,
                   name: 'nubank'
                 }
               }
             }, headers: authenticate_headers(user_one), as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested checking_account' do
        patch "/api/checking_accounts/#{checking_account_one.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    name: 'novo nome'
                  }
                }
              }, headers: authenticate_headers(user_one), as: :json
        checking_account_one.reload

        expect(checking_account_one.account.name).to eq('novo nome')
      end

      it 'renders a JSON response with the checking_account' do
        patch "/api/checking_accounts/#{checking_account_one.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    name: 'novo nome'
                  }
                }
              }, headers: authenticate_headers(user_one), as: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the checking_account' do
        patch "/api/checking_accounts/#{checking_account_one.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    balance: 150.00
                  }
                }
              }, headers: authenticate_headers(user_one), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with unauthorized user' do
      it 'renders a JSON response with error for the checking_account' do
        patch "/api/checking_accounts/#{checking_account_one.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    name: 'novo nome'
                  }
                }
              }, headers: authenticate_headers(user_two), as: :json

        checking_account_one.reload
        parsed_body = JSON.parse(response.body)

        expect(checking_account_one.account.name).not_to eq('novo nome')
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body['error']).to eq('Unauthorized')
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with authorized user' do
      before do
        delete "/api/checking_accounts/#{checking_account_one.id}", headers: authenticate_headers(user_one),
                                                                    as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 204, no content' do
        expect(response.status).to eq(204)
      end

      it 'destroys the requested account' do
        expect(CheckingAccount.count).to eq(0)
      end
    end

    context 'with unauthorized user' do
      it 'renders a JSON response with error for the checking_account' do
        delete "/api/checking_accounts/#{checking_account_one.id}", headers: authenticate_headers(user_two),
                                                                    as: :json

        parsed_body = JSON.parse(response.body)

        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body['error']).to eq('Unauthorized')
      end
    end
  end
end
