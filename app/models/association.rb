class Association < ActiveRecord::Base

  has_many :memberships, as: :membershipable, dependent: :destroy
  has_many :users, through: :memberships

  has_many :families
  has_many :members
  has_many :teams

end
