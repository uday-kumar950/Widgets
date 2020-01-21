class WidgetService

	def initialize
	    @client_id = "277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe"
	    @client_secret = "d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352"
	end

	def visible_data
		response = RestClient.get 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible', {params: {client_id: @client_id, client_secret: @client_secret}}
		if response.code == 200
			res_body = JSON.parse(response.body)
			res_body["data"]["widgets"]
		else
			[]
		end
	end

	def search_visible_widget(term)
		response = RestClient.get 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible', {params: {client_id: @client_id, client_secret: @client_secret,term: term}}
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
			res_body = JSON.parse(response.body)
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
			puts response = JSON.parse(response.body)
			if response["code"] == 0
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
			puts response = JSON.parse(response.body)
			if response["code"] == 0
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
			puts response = JSON.parse(response.body)
			if response["code"] == 0
				is_deleted = true
			end
		rescue => ex
		 	puts ex
		end
		is_deleted
	end


end
