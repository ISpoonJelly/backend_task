require 'rails_helper'

RSpec.describe 'States API', type: :request do
  # initialization
  let!(:states) { create_list(:state, 10) }
  let(:state_id) { states.first.id }

  # Test suite for GET /states
  describe 'GET /states' do
    before { get '/states' }

    it 'returns states' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /states/:id
  describe 'GET /states/:id' do
    before { get "/states/#{state_id}" }

    context 'when the record exists' do
      it 'returns the state' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(state_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:state_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find State/)
      end
    end
  end

  # Test suite for PUT /states/:id
  describe 'PUT /states/:id' do
    let(:valid_attributes) { { device: 'Google Pixel' } }

    context 'when the record exists' do
      before { put "/states/#{state_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /states/:id
  describe 'DELETE /states/:id' do
    before { delete "/states/#{state_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
