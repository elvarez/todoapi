class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  private

  def authenticated?
    authenticate_or_request_with_http_basic {|name, password| User.where( name: name, password: password).present? }
  end

  def current_user
    creds = ActionController::HttpAuthentication::Basic.decode_credentials(request).to_s
    creds = creds.split(":")
    @current_user = User.find_by(name: creds[0], password: creds[1])
  end

  def allow?(controller, action, resource = nil)
    case controller
    when "api/lists"
      case action
      when "destroy"
        current_user.id == resource.user_id
      when "update"
        current_user.id == resource.user_id
      else
        true
      end
    when "api/items"
      case action
      when "destroy"
        current_user == resource.list.user_id
      when "update"
        current_user == resource.list.user_id
      else
        true
      end
    else
      true
    end
  end

  def current_resource
    nil
  end
  
  def authorize?
    if !allow?(params[:controller], params[:action], current_resource)
      render text: "Not authorized"
    end
  end

  
end
