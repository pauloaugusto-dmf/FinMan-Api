require 'rails_helper'

RSpec.describe Api::IncomesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/incomes').to route_to('api/incomes#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/incomes/1').to route_to('api/incomes#show', id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/incomes').to route_to('api/incomes#create', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/incomes/1').to route_to('api/incomes#update', id: '1', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/incomes/1').to route_to('api/incomes#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/incomes/1').to route_to('api/incomes#destroy', id: '1', format: :json)
    end
  end
end
