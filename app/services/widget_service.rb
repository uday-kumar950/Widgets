class WidgetService

	def initialize
	    @client_id = AdminType::CLIENT_ID
	    @client_secret = AdminType::CLIENT_SECRET
	end

	def visible_data
		response = RestClient.get 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible', {params: {client_id: @client_id, client_secret: @client_secret}}
		if response.code == 200
			puts res_body = JSON.parse(response.body)
			res_body["data"]["widgets"]
		else
			[]
		end
	end

	def search_visible_widgets(term)
		response = RestClient.get 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible', {params: {client_id: @client_id, client_secret: @client_secret,term: term}}
		if response.code == 200
			res_body = JSON.parse(response.body)
			res_body["data"]["widgets"]
		else
			[]
		end
	end

	def search_user_visible_widgets(user,id,term)
		response = RestClient.get "https://showoff-rails-react-production.herokuapp.com/api/v1/users/#{id}/widgets", {params: {client_id: @client_id, client_secret: @client_secret,term: term},:Authorization => "Bearer #{user.access_token}"}
		if response.code == 200
			res_body = JSON.parse(response.body)
			res_body["data"]["widgets"]
		else
			[]
		end
	end

	def user_widgets(user,id)
		response = RestClient.get "https://showoff-rails-react-production.herokuapp.com/api/v1/users/#{id}/widgets", {params: {client_id: @client_id, client_secret: @client_secret},:Authorization => "Bearer #{user.access_token}"}
		if response.code == 200
			puts res_body = JSON.parse(response.body)
			res_body["data"]["widgets"]
		else
			[]
		end
	end

	def get_user_details(user,id)
		response = RestClient.get "https://showoff-rails-react-production.herokuapp.com/api/v1/users/#{id}", {:Authorization => "Bearer #{user.access_token}"}
		if response.code == 200
			res_body = JSON.parse(response.body)
			res_body["data"]["user"]
		else
			[]
		end
	end

	def create_widget(user,widget_data)
		is_created = false
		begin
			response = RestClient.post "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets", {widget: {name: widget_data[:name],kind: widget_data[:kind],description: widget_data[:description]}}.to_json, {:Authorization => "Bearer #{user.access_token}",content_type: :json, accept: :json}
			if response.code == 200
				is_created = true
			end
		rescue => ex
		 	puts ex
		end
		is_created
	end

	def update_widget(user,widget_data,id)
		is_updated = false
		begin
			response = RestClient.put "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/#{id}", {widget: {name: widget_data[:name],description: widget_data[:description]}}.to_json, {:Authorization => "Bearer #{user.access_token}",content_type: :json, accept: :json}
			if response.code == 200
				is_updated = true
			end
		rescue => ex
		 	puts ex
		end
		is_updated
	end

	def delete_widget(user,id)
		is_deleted = false
		begin
			response = RestClient.delete "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/#{id}",{:Authorization => "Bearer #{user.access_token}",content_type: :json, accept: :json}
			if response.code == 200
				is_deleted = true
			end
		rescue => ex
		 	puts ex
		end
		is_deleted
	end


end
