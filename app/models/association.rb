class Association < ActiveRecord::Base
  include Tokenable

  has_many :memberships, as: :membershipable, dependent: :destroy
  has_many :users, through: :memberships

  has_many :families, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :teams, dependent: :destroy

end
