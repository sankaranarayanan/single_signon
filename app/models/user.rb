class User < ActiveRecord::Base
  attr_accessible :email, :name, :image, :location

  has_many :authentications, :dependent => :destroy

  validates :email, :presence => true, :uniqueness => true

  after_create :send_confirmation_email, :authorize

  def authorize
    Doorkeeper::Application.all.each do |app|
      Authorization.new(self,
        :response_type => 'code',
        :client_id => app.uid,
        :redirect_uri => app.redirect_uri
        ).grant_token
    end
  end

  def as_json(options={})
    {
      :provider => 'sample',
      :id => id.to_s,
      :email => email,
      :info => {
         :email => email
      }
    }
  end

  private
  def send_confirmation_email
    Mailer.enqueue.welcome(self.attributes)
  end
end
