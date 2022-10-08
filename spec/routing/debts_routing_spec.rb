require 'rails_helper'

RSpec.describe Api::DebtsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/debts').to route_to('api/debts#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/debts/1').to route_to('api/debts#show', id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/debts').to route_to('api/debts#create', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/debts/1').to route_to('api/debts#update', id: '1', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/debts/1').to route_to('api/debts#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/debts/1').to route_to('api/debts#destroy', id: '1', format: :json)
    end
  end
end
