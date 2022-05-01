require 'rails_helper'

RSpec.describe Api::TransactionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/transactions').to route_to('api/transactions#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/transactions/1').to route_to('api/transactions#show', id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/transactions').to route_to('api/transactions#create', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/transactions/1').to route_to('api/transactions#update', id: '1', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/transactions/1').to route_to('api/transactions#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/transactions/1').to route_to('api/transactions#destroy', id: '1', format: :json)
    end
  end
end
