class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :setup_security
  attr_reader :security

  def setup_security
    @security = ItinerarySecurity.new(current_user)
  end

end
