class Link < ActiveRecord::Base

  def self.generate_key
    letters_numbers = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    key_string = ''
    8.times { key_string << letters_numbers.sample }
    key_string
  end

end
