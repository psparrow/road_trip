class ApplicationController < ActionController::Base
  attr_reader :user

  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :setup_security

  def setup_security
    @user = UserSecurity.new(current_user)
  end

end
