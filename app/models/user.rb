class User < ActiveRecord::Base
  rolify
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships


  has_many :events, as: :organizer, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :assigned_events, through: :assignments

  has_and_belongs_to_many :structures

  has_one :member

  before_create :set_default_role

  after_initialize :set_default_role, :if => :new_record?

  validates :firstname, :lastname, presence: true


  def name
    if firstname? && lastname?
      "#{firstname} #{lastname}"
    else
      email
    end
  end

  def is_leader?
    memberships.where(is_leader: true).any?
  end

  def set_default_role
    self.role ||= :user
  end

end
