module UsersHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def profile_image_for(user, class_name: "", large: false)
    alt = get_full_name_for(user)
    if user.image
      src = user.image
      src += '?type=large' if large
    else
      src = gravatar_url(user)
      src += '?s=200' if large
    end
    image_tag(src, alt: alt, class: class_name)
  end

  def get_full_name_for(user)
    user.first_name + " " + user.last_name
  end
end
