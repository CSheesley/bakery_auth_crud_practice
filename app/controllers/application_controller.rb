class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionView::Helpers::TextHelper

  helper_method :current_baker

  def current_baker
    @current_baker ||= Baker.find(session[:user_id]) if session[:user_id]
  end
end
