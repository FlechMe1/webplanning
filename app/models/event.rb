class Event < ActiveRecord::Base

  belongs_to :organizer, polymorphic: true
  has_many :assignments, dependent: :destroy
  accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  validates :label, :begin_at, :end_at, :organizer_id, :organizer_type, presence: true
  validate :is_date_valid?

  def is_date_valid?
    if !begin_at.blank? && !end_at.blank? && begin_at > end_at
      errors.add(:period, "La période est invalide")
    end
  end
end
