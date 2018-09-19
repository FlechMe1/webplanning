class Member < ActiveRecord::Base

  belongs_to :user

  def name
    lastname + " " + firstname
  end
end
