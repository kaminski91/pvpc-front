class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_api
  before_action :load_lang

  require 'rest-client'

  def set_api
  	@api = RestClient::Resource.new( 'https://pvpc-core.herokuapp.com/api/v1', 'pvpc', 'pefalpe987' )
  end

  def load_lang
    I18n.locale = cookies[:pvpc_user_lang].try(:to_sym) || I18n.default_locale
  end

  def set_lang
  	session[:return_to] ||= request.referer || root_url
  	I18n.locale = params[:lang].to_sym
    cookies[:pvpc_user_lang] = { :value => params[:lang], :expires => 1.year.from_now }
  	redirect_to session.delete(:return_to)
  end
end
