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
    option_1 = number % 10
    option_2 = number % 100

    case
    when (11..14).include?(option_2)
      var3
    when option_1 == 1
      var1
    when (2..4).include?(option_1)
      var2
    else
      var3
    end
  end
end
