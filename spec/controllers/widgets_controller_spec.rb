require 'rails_helper'

RSpec.describe WidgetsController, type: :controller do

  ACCESS_TOKEN = "18f1b45cb15b21265da56928341bd78fffd9278911c8104b523960f4e9dfd223"
  USER_ID = "1"
  WIDGET_ID = ""
  
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
        puts response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widgets"].length).not_to eq(0)

        response = RestClient.get "https://showoff-rails-react-production.herokuapp.com/api/v1/users/#{USER_ID}/widgets", {params: {client_id: AdminType::CLIENT_ID, client_secret: AdminType::CLIENT_SECRET,term: "A Visible Widget"},:Authorization => "Bearer #{ACCESS_TOKEN}"}
        expect(response.code).to eq(200)
        puts response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widgets"].length).not_to eq(0)
      end
    end
  end


  describe 'create widget' do
    context 'when API call' do
      it 'get widget' do
        widget_data = {name: "widget test1",kind: 'visible',description: "testing widget1"}
        response = RestClient.post "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets", {widget: {name: widget_data[:name],kind: widget_data[:kind],description: widget_data[:description]}}.to_json, {:Authorization => "Bearer #{ACCESS_TOKEN}",content_type: :json, accept: :json}
        expect(response.code).to eq(200)
        puts response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widget"].length).not_to eq(0)
        WIDGET_ID = response_data["data"]["widget"]["id"].to_s
      end
    end
  end


  describe 'update widget' do
    context 'when API call' do
      it 'get widget' do
        widget_data = {name: "widget test12",description: "testing widget12"}
        response = RestClient.put "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/#{WIDGET_ID}", {widget: {name: widget_data[:name],description: widget_data[:description]}}.to_json, {:Authorization => "Bearer #{ACCESS_TOKEN}",content_type: :json, accept: :json}
        expect(response.code).to eq(200)
        puts response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widget"].length).not_to eq(0)
      end
    end
  end

  describe 'delete widget' do
    context 'when API call' do
      it 'check deleted widget' do
        response = RestClient.delete "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/#{WIDGET_ID}",{:Authorization => "Bearer #{ACCESS_TOKEN}",content_type: :json, accept: :json}
        expect(response.code).to eq(200)
        puts response_data = JSON.parse(response.body)
        expect(response_data["data"].length).not_to eq(0)
        expect(response_data["data"]["widget"]).to eq(nil)
      end
    end
  end

end