class UsersController < ApplicationController
  
  def login
  end

  def login_auth
  	if params[:email].blank? || params[:password].blank?
  		redirect_to login_path, notice: 'Wypełnij pola dziwko'
  		return
  	end

  	response = @api['users/login'].post email: params[:email], password: params[:password]
  	redirect_to root_path, notice: response
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
end
