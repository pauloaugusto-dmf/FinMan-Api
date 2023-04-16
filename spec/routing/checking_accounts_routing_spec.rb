require 'rails_helper'

RSpec.describe Api::CheckingAccountsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/checking_accounts').to route_to('api/checking_accounts#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/checking_accounts/1').to route_to('api/checking_accounts#show', id: '1',
                                                                                        format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/checking_accounts').to route_to('api/checking_accounts#create',
                                                         format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/checking_accounts/1').to route_to('api/checking_accounts#update', id: '1',
                                                                                          format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/checking_accounts/1').to route_to('api/checking_accounts#update',
                                                            id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/checking_accounts/1').to route_to('api/checking_accounts#destroy',
                                                             id: '1', format: :json)
    end
  end
end
