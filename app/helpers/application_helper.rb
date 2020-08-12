module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def inclination(number, one, few, many)
    option1 = number % 10
    option2 = number % 100

    return many if (11..14).include?(option2)
    case option1
    when 1 then one
    when 2..4 then few
    else many
    end
  end
end
