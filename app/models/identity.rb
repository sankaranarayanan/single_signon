class Identity < OmniAuth::Identity::Models::ActiveRecord
  attr_accessible :email, :password

  validates :email, :presence => true, :uniqueness => true

  def send_password_reset(redirect_uri = '')
    generate_token(:password_reset_token)
    save!
    user = User.find_by_email(email)
    Mailer.enqueue.password_reset(user.attributes.merge(:redirect_uri => redirect_uri, :password_reset_token => password_reset_token))
  end

private
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Identity.exists?(column => self[column])
  end
end
