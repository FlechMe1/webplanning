class Public::MembersController < ApplicationController

  before_action :create_family, only: [:create, :update]

  layout 'public'

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to public_home_page, notice: 'Votre inscription a été prise en compte'
    else
      render 'public/pages/home'
    end
  end

  private
    def member_params
      params.required(:member).permit(:gender, :firstname, :lastname, :birthdate, :email, :phone_1, :phone_2, :address_1, :cgu,
                                       :user_id, :address_2, :zipcode, :town, sibling_attributes: [:family_id, :status])
    end

    def create_family
      if params[:member] && params[:member][:sibling_attributes] && params[:member][:sibling_attributes][:family_id] == 'new_family'
        @family = Family.new(name: params[:member][:lastname])
        @family.email = params[:member][:email]
        @family.phone_1 = params[:member][:phone_1]
        @family.address_1 = params[:member][:address_1]
        @family.address_2 = params[:member][:address_2]
        @family.zipcode = params[:member][:zipcode]
        @family.town = params[:member][:town]
        @family.save

        params[:member][:sibling_attributes][:family_id] = @family.id
      end
    end
end
