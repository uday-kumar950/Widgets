class AuthService

	def initialize
	    @client_id = "277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe"
	    @client_secret = "d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352"
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

end