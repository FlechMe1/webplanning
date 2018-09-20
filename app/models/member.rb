class Member < ActiveRecord::Base

  belongs_to :user
  has_one :sibling, :dependent => :destroy
  has_one :family, through: :sibling
  accepts_nested_attributes_for :sibling

  delegate :name, :id, :to => :family, :prefix => true, allow_nil: true
  delegate :get_status, :to => :sibling, :prefix => true, allow_nil: true

  validates :gender, :lastname, :firstname, presence: true

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

  def has_family?
    !family.blank?
  end

  def has_user?
    !user.blank?
  end
end
