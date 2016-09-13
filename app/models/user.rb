class User < ActiveRecord::Base
  rolify
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :teams, through: :memberships

  before_create :set_default_role

  after_initialize :set_default_role, :if => :new_record?

  validates :firstname, :lastname, presence: true


  def name
    if !firstname.blank? && !lastname.blank?
      "#{firstname} #{lastname}"
    else
      email
    end
  end

  def set_default_role
    self.role ||= :user
  end

end
