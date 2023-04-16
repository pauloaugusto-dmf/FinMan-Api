require 'rails_helper'

RSpec.describe '/tags', type: :request do
  let(:user) { create :user }
  let(:tag) { create :tag }

  describe 'GET /index' do
    before do
      get '/api/tags', headers: authenticate_headers(user), as: :json
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
      get "/api/tags/#{tag.id}", headers: authenticate_headers(user), as: :json
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
        post '/api/tags/',
             params: {
               tag: {
                 name: 'Alimentação'
               }
             }, headers: authenticate_headers(user), as: :json
      end
      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 201, created' do
        expect(response.status).to eq(201)
      end

      it 'creates a new Tag' do
        expect(Tag.count).to eq(1)
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        before do
          patch "/api/tags/#{tag.id}",
                params: {
                  tag: {
                    name: 'Transporte'
                  }
                }, headers: authenticate_headers(user), as: :json
        end

        it 'renders a successful response' do
          expect(response).to be_successful
        end

        it 'returns 200' do
          expect(response.status).to eq(200)
        end

        it 'modify the value attribute' do
          expect(Tag.find(tag.id).name).to eq('Transporte')
        end
      end
    end

    describe 'DELETE /destroy' do
      before do
        delete "/api/tags/#{tag.id}", headers: authenticate_headers(user), as: :json
      end
      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'returns 204, no content' do
        expect(response.status).to eq(204)
      end

      it 'destroys the requested transaction' do
        expect(Tag.count).to eq(0)
      end
    end
  end
end
