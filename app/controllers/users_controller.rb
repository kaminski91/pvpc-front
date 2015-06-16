class UsersController < ApplicationController
  
  def login
  end

  def login_auth
  	if params[:email].blank? || params[:password].blank?
  		redirect_to login_path, notice: 'Wypełnij pola dziwko'
  		return
  	end

  	@api['users/login'].post email: params[:email], password: params[:password] do |response, request, result|
      case response.code
      when 200
        user_data = JSON.parse(response)
        login_user(user_data["id"], user_data["email"], user_data["nickname"], user_data["access_token"])
        redirect_to root_path, notice: "Witaj #{session[:user_nickname]}"
      when 422
        redirect_to root_path, notice: "Błędny login lub hasło"
      else
        redirect_to root_path, notice: "Ups coś poszło nie tak"
      end
    end

  	# redirect_to root_path, notice: response.code
  end

  def registration
  end

  def registration_auth
  	if params[:email].blank? || params[:nickname].blank? || params[:password].blank?
  		redirect_to registration_path, notice: 'Wypełnij pola dziwko'
  		return
  	end

  	response = @api['users'].post user: {email: params[:email], nickname: params[:nickname], password: params[:password]}

  	redirect_to root_path, notice: "#{email} | #{nickname} | #{password}"
  end

  def logout
    # @current_user = session[:user_id] = session[:user_token] = session[:user_nickname] = session[:user_email] = nil
    @current_user = nil
    reset_session
    redirect_to root_url
  end

  private
  def login_user(id, email, nickname, token)
    session[:user_id] = id
    session[:user_token] = token
    session[:user_nickname] = nickname
    session[:user_email] = email
  end


end
