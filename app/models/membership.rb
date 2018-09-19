class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :status, inclusion: { in: %w(father mother child),
    message: "%{value} n'est pas un statut valide" }
end
