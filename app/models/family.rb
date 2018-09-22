class Family < ActiveRecord::Base

  has_many :siblings, dependent: :destroy
  has_many :members, through: :siblings

  validates :name, presence: true

  def full_address
    address = ""
    address += "#{address_1}" if address_1?
    address += " #{address_2}" if address_2?
    address += " #{zipcode}" if zipcode?
    address += " #{town}" if town?

    address
  end
end
