class Structure < ActiveRecord::Base
  include Tokenable
  scopify

  has_and_belongs_to_many :users

  has_many :members
  has_many :families
  has_many :categories

  validates :name, presence: true

  after_commit :create_default_data, on: :create

  def create_default_data
    SeedStructureService.call(self.id)
  end

end
