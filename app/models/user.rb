class User < ActiveRecord::Base
  has_many :links, dependent: :destroy
  # Remember to create a migration!

  def self.verify_password(password_one, password_two)
    password_one == password_two
  end

  def self.validate_user(email, password)
    user = User.find_by_email(email)
    if user != nil
      return user.password == password
    else
      return false
    end
  end
end
