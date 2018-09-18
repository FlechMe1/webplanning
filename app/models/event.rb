class Event < ActiveRecord::Base
  require 'icalendar'

  belongs_to :organizer, polymorphic: true
  has_many :assignments, dependent: :destroy

  accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  validates :label, :begin_at, :end_at, :organizer_id, :organizer_type, presence: true
  validate :is_date_valid?

  def is_date_valid?
    if !begin_at.blank? && !end_at.blank? && begin_at >= end_at
      errors.add(:period, "La période est invalide")
    end
  end

  def self.get_personnal_events(user_id, begin_at = nil, end_at = nil, team_id = nil)

    assignments = Assignment.where(user_id: user_id).joins(:event)

    if begin_at
      assignments = assignments.where('events.begin_at > ?', begin_at)
    end

    if end_at
      assignments = assignments.where('events.end_at < ?', end_at)
    end

    if team_id
      assignments = assignments.where('events.organizer_type = ? AND events.organizer_id = ?', 'Team', team_id)
    end

    events = []
    assignments.each do |a|
      a.event.label = a.event.label + " - " + a.description
      events << a.event
    end
    events
  end
end
