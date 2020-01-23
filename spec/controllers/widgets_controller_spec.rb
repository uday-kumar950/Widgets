require 'rails_helper'

RSpec.describe WidgetsController, type: :controller do
  ACCESS_TOKEN = "18f1b45cb15b21265da56928341bd78fffd9278911c8104b523960f4e9dfd223"
  USER_ID = "1"
  describe 'visible widgets on landing page' do
  	context 'when API call' do
  	  it 'get widgets' do
        response = RestClient.get 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible', {params: {client_id: AdminType::CLIENT_ID, client_secret: AdminType::CLIENT_SECRET}}
        expect(response.code).to eq(200)
  	  	response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widgets"].length).not_to eq(0)

        response = RestClient.get "https://showoff-rails-react-production.herokuapp.com/api/v1/users/#{USER_ID}/widgets", {params: {client_id: AdminType::CLIENT_ID, client_secret: AdminType::CLIENT_SECRET},:Authorization => "Bearer #{ACCESS_TOKEN}"}
        expect(response.code).to eq(200)
        response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widgets"].length).not_to eq(0)
  	  end
  	end
  end


  describe 'search widgets' do
    context 'when API call' do
      it 'get widgets' do
        response = RestClient.get 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible', {params: {client_id: AdminType::CLIENT_ID, client_secret: AdminType::CLIENT_SECRET,term: "A Visible Widget"}}
        expect(response.code).to eq(200)
        response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widgets"].length).not_to eq(0)

        response = RestClient.get "https://showoff-rails-react-production.herokuapp.com/api/v1/users/#{USER_ID}/widgets", {params: {client_id: AdminType::CLIENT_ID, client_secret: AdminType::CLIENT_SECRET},:Authorization => "Bearer #{ACCESS_TOKEN}"}
        expect(response.code).to eq(200)
        response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widgets"].length).not_to eq(0)
      end
    end
  end


end