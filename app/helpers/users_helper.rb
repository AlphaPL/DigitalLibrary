module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def get_person_who_borrowed(borrowed_id)
    user = User.find(Possession.where(borrowed_id: borrowed_id).first.borrower_id)
    "#{user.name} #{user.surname}"
  end
  
end