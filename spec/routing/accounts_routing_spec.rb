require 'rails_helper'

RSpec.describe Api::AccountsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/accounts').to route_to('api/accounts#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/accounts/1').to route_to('api/accounts#show', id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/accounts').to route_to('api/accounts#create', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/accounts/1').to route_to('api/accounts#update', id: '1', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/accounts/1').to route_to('api/accounts#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/accounts/1').to route_to('api/accounts#destroy', id: '1', format: :json)
    end
  end
end
