class Permission < Struct.new(:user)

  def allow?(controller, action, resource = nil,  res = nil)
    case controller
    when "api/lists"
      case action
      when "index", "show"
        if resource.permission == "private"
          resource.user_id == user.id
        else
          true
        end
      when "destroy", "update"
        user.id == resource.user_id || resource.permission == "open"
      else
        true
      end
    when "api/items"
      case action
      when "create"
        res.user_id == user.id
      when "destroy", "update"
        user.id == resource.list.user_id || resource.list.permission == "open"
      else
        true
      end
    else
      true
    end
  end
end
