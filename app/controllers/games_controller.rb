class GamesController < ApplicationController
	def index
		@api["games"].get access_token: current_user.token do |response, request, result|
			case response.code
			when 200
				@games = JSON.parse(response)
			else
        redirect_to root_path, notice: "Ups coś poszło nie tak"
			end
		end	
	end

	def show
		@api["games/#{params[:id]}"].get id: params[:id] do |response, request, result|
			case response.code
			when 200
				@game = JSON.parse(response)
			else
        redirect_to root_path, notice: "Ups coś poszło nie tak"
			end
		end			
	end
end
