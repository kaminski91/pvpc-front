class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_api

  require 'rest-client'

  def set_api
  	@api = RestClient::Resource.new( 'https://pvpc-core.herokuapp.com/api/v1', 'pvpc', 'pefalpe987' )
  end

  def set_lang
  	session[:return_to] ||= request.referer
  	I18n.locale = params[:lang].to_sym
  	redirect_to session.delete(:return_to)
  end
end
