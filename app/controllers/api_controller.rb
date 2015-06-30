class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :authenticated?
  before_action :authorize?
  
  private

  def authenticated?
    authenticate_or_request_with_http_basic {|name, password| User.where( name: name, password: password).present? }
  end

  def current_user
    creds = ActionController::HttpAuthentication::Basic.decode_credentials(request).to_s
    creds = creds.split(":")
    @current_user ||= User.find_by(name: creds[0], password: creds[1])
  end

  def current_resource
    nil
  end

  def list_res
    nil
  end
  
  def authorize?
    if !Permission.new(current_user).allow?(params[:controller], params[:action], current_resource, list_res)
      render text: "Not authorized"
    end
  end

end
