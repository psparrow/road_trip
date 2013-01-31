class User < ActiveRecord::Base
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  attr_accessible :login, :username, :email, :password,
                  :password_confirmation, :remember_me,
                  :authentication_keys => [:login]

  has_many :itineraries
  has_many :contributors

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

  def self.invite_by_email(email)
    invite!(email: email, username: "User#{count}") do |u|
      u.skip_invitation = true
    end
  end
end
