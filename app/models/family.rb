class Family < ActiveRecord::Base

  has_many :siblings, dependent: :destroy
  has_many :members, through: :siblings

  validates :name, presence: true

  def full_address
    "#{address_1} #{address_2} - #{zipcode} #{town}"
  end
end
