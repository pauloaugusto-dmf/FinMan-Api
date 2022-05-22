require 'rails_helper'

RSpec.describe Api::TagsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/tags').to route_to('api/tags#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/tags/1').to route_to('api/tags#show', id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/tags').to route_to('api/tags#create', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/tags/1').to route_to('api/tags#update', id: '1', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/tags/1').to route_to('api/tags#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/tags/1').to route_to('api/tags#destroy', id: '1', format: :json)
    end
  end
end
