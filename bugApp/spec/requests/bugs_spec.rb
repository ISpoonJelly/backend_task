require 'rails_helper'

RSpec.describe 'Bugs API' do
  # Initialization
  let!(:bugs) { create_list(:bug, 20, state_id: state.id) }
  let(:bug_id) { bugs.first.id }

  # Test suite for GET /states/:state_id/bugs
  describe 'GET /bugs' do
    before { get "/bugs" }

    it 'returns all bugs' do
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /bugs/:number?appToken=:appToken
  describe 'GET /bugs/:number?appToken=:appToken' do
    before { get "/bugs/#{bug_id}" }

    context 'when the record exists' do
      it 'returns the bug' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bug_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bug_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bug/)
      end
    end
  end

  # Test suite for POST /bugs
  describe 'POST /bugs' do
    let!(:mockstate) { create(:state) }
    let(:valid_attributes) {{ appToken: '01234BCDEF', number: rand(100), status: 'fresh', priority: 'major', comment: 'Serious Bug', state: mockstate }}

    context 'when the request is valid' do
      before { post '/bugs', params: valid_attributes }

      it 'creates a bug' do
        expect(json['appToken']).to eq('01234BCDEF')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are missing' do
      before { post '/states', params: { appToken: '01234BCDEF' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Device can't be blank, Os can't be blank, Memory can't be blank, Storage can't be blank/)
      end
    end
  end

  # Test suite for PUT /bugs/:id
  describe 'PUT /bugs/:id' do
    let(:valid_attributes) { { priority: :critical } }

    context 'when the record exists' do
      before { put "/bugs/#{bug_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /bugs/:id
  describe 'DELETE /bugs/:id' do
    before { delete "/bugs/#{bug_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
