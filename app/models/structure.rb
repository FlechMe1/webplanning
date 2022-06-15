class Structure < ActiveRecord::Base
  include Tokenable
  scopify

  has_and_belongs_to_many :users

  has_many :members

  validates :name, presence: true

end
