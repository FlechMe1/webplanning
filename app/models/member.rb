class Member < ActiveRecord::Base

  belongs_to :user
  has_one :sibling
  has_one :family, through: :sibling
  accepts_nested_attributes_for :sibling

  delegate :name, :id, :to => :family, :prefix => true, allow_nil: true

  validates :gender, :lastname, :firstname, :email, :phone_1, presence: true

  def name
    lastname + " " + firstname
  end

  def full_address
    "#{address_1} #{address_2} - #{zipcode} #{town}"
  end

  def get_gender
    case gender
    when 'male'
      "Mr"
    when 'female'
      "Mme"
    end
  end
end
