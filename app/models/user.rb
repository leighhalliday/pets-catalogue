class User < ActiveRecord::Base

  has_many :pets

  def name
    "#{self.first_name} #{self.last_name}"
  end

end
