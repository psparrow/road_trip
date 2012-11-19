class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  attr_accessible :login, :username, :email, :password,
                  :password_confirmation, :remember_me,
                  :authentication_keys => [:login]

  has_many :contributors
  has_many :itineraries

  def shared_itineraries
    contributors.map { |c| c.itinerary }
  end

  def all_itineraries
    itineraries + shared_itineraries
  end

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

end
