require 'rails_helper'

RSpec.describe '/checking_accounts', type: :request do
  let(:user) { create :user }
  let(:checking_account) { create :checking_account }

  describe 'GET /index' do
    it 'renders a successful response' do
      get '/api/checking_accounts', headers: authenticate_headers(user), as: :json

      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get "/api/checking_accounts/#{checking_account.id}", headers: authenticate_headers(user),
                                                           as: :json

      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new CheckingAccount' do
        expect do
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
               }, headers: authenticate_headers(user), as: :json
        end.to change(CheckingAccount, :count).by(1)
      end

      it 'renders a JSON response with the new checking_account' do
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
             }, headers: authenticate_headers(user), as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new CheckingAccount' do
        expect do
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
               }, headers: authenticate_headers(user), as: :json
        end.to change(CheckingAccount, :count).by(0)
      end

      it 'renders a JSON response with errors for the new checking_account' do
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
             }, headers: authenticate_headers(user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested checking_account' do
        patch "/api/checking_accounts/#{checking_account.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    name: 'novo nome'
                  }
                }
              }, headers: authenticate_headers(user), as: :json
        checking_account.reload

        expect(checking_account.account.name).to eq('novo nome')
      end

      it 'renders a JSON response with the checking_account' do
        patch "/api/checking_accounts/#{checking_account.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    name: 'novo nome'
                  }
                }
              }, headers: authenticate_headers(user), as: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the checking_account' do
        patch "/api/checking_accounts/#{checking_account.id}",
              params: {
                checking_account: {
                  account_attributes: {
                    balance: 150.00
                  }
                }
              }, headers: authenticate_headers(user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete "/api/checking_accounts/#{checking_account.id}", headers: authenticate_headers(user),
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
end
