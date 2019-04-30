module UsersHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def profile_image_for(user, class_name: "")
    alt = get_full_name_for(user)
    src = user.image || gravatar_url(user)
    image_tag(src, alt: alt, class: class_name)
  end

  def get_full_name_for(user)
    user.first_name + " " + user.last_name
  end
end
