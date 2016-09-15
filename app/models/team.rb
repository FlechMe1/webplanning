class Team < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :events, as: :organizer, dependent: :destroy

  validates :label, presence: true

  def is_leader?(user_id)
    memberships.where('is_leader').pluck(:user_id).include?(user_id)
  end
end
