class User < ActiveRecord::Base
  # Remember to create a migration!

  def self.verify_password(password_one, password_two)
    password_one == password_two
  end

  def self.validate_user(email, password)
    User.find_by_email(email) == User.find_by_password(password)
  end
end
