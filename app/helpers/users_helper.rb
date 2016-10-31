module UsersHelper
  def gravatar_for user, options = {size: 50}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    if user.avatar?
      image_tag user.avatar.url , alt: user.name, class: "gravatar"
    else
      image_tag "user.png" , alt: user.name, class: "gravatar"
    end
  end
end
