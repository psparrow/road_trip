class User < ActiveRecord::Base
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  attr_accessible :login, :username, :email, :password,
                  :password_confirmation, :remember_me,
                  :authentication_keys => [:login]

  validates :username,
    length:     { in: 6..20 },
    uniqueness: { case_sensitive: false }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  ### This is the correct method you override with the code above
  #### def self.find_for_database_authentication(warden_conditions)
  #### end


end
