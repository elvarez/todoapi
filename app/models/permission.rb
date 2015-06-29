class Permission < Struct.new(:user)

  def allow?(controller, action, resource = nil)
    case controller
    when "api/lists"
      case action
      when 'index', 'show'
        if resource.permission == 'private'
          resource.user_id != user.id
        else
          true
        end
      when 'destroy', 'update'
        user.id == resource.user_id || resource.permission == 'open'
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

end
