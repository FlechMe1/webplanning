class Team < ActiveRecord::Base


  belongs_to :organization, foreign_key: :association_id, class_name: "Association"

  has_many :memberships, as: :membershipable, dependent: :destroy
  has_many :users, through: :memberships
  has_many :events, as: :organizer, dependent: :destroy

  validates :label, presence: true

  def is_leader?(user_id)
    memberships.where('is_leader').pluck(:user_id).include?(user_id)
  end
end
