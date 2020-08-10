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

  def inclination(number, form1, form2, form3)
    option_1 = number % 10
    option_2 = number % 100

      if (11..14).include?(option_2)
        return form3
      elsif option_1 == 1
        return form1
      elsif (2..4).include?(option_1)
        return form2
      else
        return form3
      end
  end
end
