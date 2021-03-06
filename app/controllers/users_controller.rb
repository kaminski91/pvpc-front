class UsersController < ApplicationController

  def show
    @api["users/#{params[:id]}/game_ownerships"].get access_token: current_user.token do |response, request, result|
      @user_games = response.code
    end

    @api["users/#{params[:id]}/friendships"].get user_id: params[:id], access_token: current_user.token do |response, request, result|
      @user_friends = response.code
    end

    @tmp_user = params[:id]
  end

  def edit
  end

  def update
    if params['user'][:nickname].blank?
      redirect_to edit_user_path(current_user.id), notice: 'Wypełnij pola dziwko'
      return
    end

    @api["users/#{current_user.id}"].patch id: current_user.id, access_token: current_user.token, user: {nickname: params['user'][:nickname]} do |response, request, result|
      case response.code
      when 204
        redirect_to user_path, notice: "Profil zaktualizowany"
        current_user.nickname = session[:user_nickname] = params['user'][:nickname]
      else
        redirect_to root_path, notice: "Ups coś poszło nie tak"
      end
    end
  end
  
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

    @api['users'].post user: {email: params[:email], nickname: params[:nickname], password: params[:password]} do |response, request, result|
      case response.code
      when 200
        user_data = JSON.parse(response)
        login_user(user_data["id"], user_data["email"], user_data["nickname"], user_data["access_token"])
        redirect_to root_path, notice: "Witaj #{session[:user_nickname]}. Twoje konto zostało utworzone"
      else
        redirect_to root_path, notice: "Ups coś poszło nie tak"
      end
    end
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
