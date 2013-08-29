class Link < ActiveRecord::Base
  belongs_to :user


  def self.generate_key
    letters_numbers = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    key_string = ''
    8.times { key_string << letters_numbers.sample }
    key_string
  end

  def self.validate_format(string)
    if string =~ /https?:\/\/?/
      return string
    else
      return "http://#{string}"
    end
  end

  def self.validate_url(string)
    uri = URI.parse(string)
    begin
      Net::HTTP.get_response(uri)
      return true
    rescue
      return false
    end
  end

end
