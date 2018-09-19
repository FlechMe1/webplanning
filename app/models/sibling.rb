class Sibling < ActiveRecord::Base
  belongs_to :member
  belongs_to :family

  delegate :gender, :name, :phone_1, :phone_2, :email, :full_address, :get_gender, :to => :member, :prefix => true, allow_nil: true
end
