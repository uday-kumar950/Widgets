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


end
