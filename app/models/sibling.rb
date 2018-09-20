class Sibling < ActiveRecord::Base
  belongs_to :member
  belongs_to :family

  validates :member, :family, presence: true, allow_nil: true

  delegate :gender, :name, :phone_1, :phone_2, :email, :full_address, :get_gender, :to => :member, :prefix => true, allow_nil: true

  def get_status
    if status?
      I18n.t("activerecord.attributes.sibling.available_status.#{status}")
    else
      "Membre"
    end
  end
end
