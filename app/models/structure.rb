class Structure < ActiveRecord::Base
  include Tokenable
  scopify

  has_and_belongs_to_many :users

  validates :name, presence: true

end
