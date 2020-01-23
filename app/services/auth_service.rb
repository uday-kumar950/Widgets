class AuthService

	def initialize
	    @client_id = AdminType::CLIENT_ID
	    @client_secret = AdminType::CLIENT_SECRET
	end

	def create_user(params)
		access_token = nil
		begin
			response = RestClient.post "https://showoff-rails-react-production.herokuapp.com/api/v1/users", {client_id: @client_id, client_secret: @client_secret,user: {"first_name"=> params[:first_name],"last_name"=> params[:last_name],"password"=> params[:password],"email"=> params[:email],"image_url"=> "https://static.thenounproject.com/png/961-200.png"}}.to_json, {content_type: :json, accept: :json}
			puts response = JSON.parse(response.body)
			if response["code"] == 0
				access_token = response["data"]["token"]["access_token"]
			end
		rescue => ex
		 	access_token
		end
		sleep 2
		access_token
	end

	def reset_password(user,current_password,new_password)
		is_updated = false
		begin
			response = RestClient.post "https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/password", {user: {current_password: current_password,new_password: new_password}}.to_json, {:Authorization => "Bearer #{user.access_token}",content_type: :json, accept: :json}
			puts response = JSON.parse(response.body)
			if response["code"] == 0
				is_updated = true
			end
		rescue => ex
		 	puts ex
		end
		is_updated
	end

end