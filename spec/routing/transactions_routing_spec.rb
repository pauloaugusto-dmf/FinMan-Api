require 'rails_helper'

RSpec.describe Api::TransactionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/accounts/1/transaction').to route_to('api/transactions#index',
                                                             format: :json, account_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/accounts/1/transaction/1').to route_to('api/transactions#show',
                                                               format: :json, account_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/accounts/1/transaction').to route_to('api/transactions#create',
                                                              format: :json, account_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/accounts/1/transaction/1').to route_to('api/transactions#update', id: '1',
                                                                                          format: :json, account_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/accounts/1/transaction/1').to route_to('api/transactions#update',
                                                                 id: '1', format: :json, account_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/accounts/1/transaction/1').to route_to('api/transactions#destroy',
                                                                  id: '1', format: :json, account_id: '1', id: '1')
    end
  end
end
