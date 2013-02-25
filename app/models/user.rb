class User < ActiveRecord::Base

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  attr_accessible :login, :username, :email, :password,
                  :password_confirmation, :remember_me,
                  :authentication_keys => [:login]

  has_many :itineraries
  has_many :contributors
  has_many :stops

  has_many :shared_itineraries, :through => :contributors, :source => :itinerary

  validates :username,
    length:     { in: 2..20 },
    uniqueness: { case_sensitive: false }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where([
        "lower(username) = :value OR lower(email) = :value",
        { :value => login.downcase }]
      ).first
    else
      where(conditions).first
    end
  end

  def self.generate_username
    "User#{count + 1}"
  end

  def self.invite_by_email(email, skip_invitation = true)
    invite!(email: email, username: generate_username) do |u|
      u.skip_invitation = skip_invitation
    end
  end
end
