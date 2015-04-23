class User < ActiveRecord::Base
  has_many :bikes
  has_many :checkins
  has_many :corrals, through: :checkins
  has_many :bike_corrals, through: :bikes
  has_many :reviews, through: :bike_corrals
  validates_presence_of :email, :name, on: :create, message: "can't be blank"
  validates_uniqueness_of :email, on: :create, message: " is already taken"
  after_create :sign_up_user

  def self.create_with_omniauth(auth)
    new do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.location = auth["info"]["location"]
      user.image_url = auth["info"]["image"]
    end
  end

  def checkin
    
  end

  def sign_up_user
    UserMailer.registration_confirmation(self).deliver_now 
  end

end
