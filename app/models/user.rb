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
  has_many :invitees

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

  def self.find_or_invite_user_by_email(email, inviter)
    if user = self.where(email: email).first
      [user, true]
    else
      user = self.invite!(
        { email: email, username: "User#{self.count}" },
        inviter
      )
      [user, false]
    end
  end

end
