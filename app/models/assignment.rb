class Assignment < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  has_one :team, through: :event, source: :organizer, source_type: 'Team'

end
