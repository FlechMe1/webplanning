class Category < ActiveRecord::Base
  belongs_to :structure

  has_many :categorizations, dependent: :destroy
  has_many :categorizables, through: :categorizations

end
