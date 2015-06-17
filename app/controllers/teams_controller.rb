class TeamsController < ApplicationController
	def index
		@api['teams'].get access_token: current_user.token do |response, request, result|
      case response.code
      when 200
        @teams = JSON.parse(response)
      else
        redirect_to root_path, notice: "Ups coś poszło nie tak (#{response.code})"
      end
    end
	end
end
