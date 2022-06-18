class Member < ActiveRecord::Base
  include Tokenable

  belongs_to :user
  belongs_to :structure
  has_one :sibling, :dependent => :destroy
  has_one :family, through: :sibling
  accepts_nested_attributes_for :sibling

  delegate :name, :id, :to => :family, :prefix => true, allow_nil: true
  delegate :get_status, :to => :sibling, :prefix => true, allow_nil: true
  delegate :name, :to => :structure, :prefix => true, allow_nil: true

  validates :lastname, :firstname, presence: true
  validates :cgu, acceptance: {accept: true} , on: :create, allow_nil: false

  has_many :categorizations, as: :categorizable
  has_many :categories, through: :categorizations
  accepts_nested_attributes_for :categories

  after_create :send_access_link

  def name
    lastname + " " + firstname
  end

  def full_address
    "#{address_1} #{address_2} - #{zipcode} #{town}"
  end

  def get_gender
    case gender
    when 'male'
      "Mr"
    when 'female'
      "Mme"
    else
      'NR'
    end
  end

  def has_family?
    !family.blank?
  end

  def has_user?
    !user.blank?
  end

  def age
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  def send_access_link
    Mailer.send_access_link(self).deliver
  end

  def categories_name
    self.categories.pluck(:name).join(', ')
  end

end
