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

  def inclination(number, var1, var2, var3)
    option1 = number % 10
    option2 = number % 100

    return 'var3' if option2 >= 11 && option2 <= 14

    case option1
      when 1 then var1
      when 2..4 then var2
      when 5..9, 0 then var3
    end
  end
end
