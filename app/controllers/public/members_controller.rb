class Public::MembersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :create_family, only: [:create, :update]

  layout 'public'

  def show
    @user = @member.user
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to public_root_path, notice: 'Votre inscription a été prise en compte'
    else
      render 'public/pages/home'
    end
  end

  def edit
    @member.build_sibling if @member.sibling.blank?
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to public_member_path(token: @member.token), notice: 'Vos informations ont été mises à jour' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  private
    def member_params
      params.required(:member).permit(:gender, :firstname, :lastname, :birthdate, :email, :phone_1, :phone_2, :address_1, :cgu,
                                       :user_id, :address_2, :zipcode, :town, sibling_attributes: [:family_id, :status])
    end

    def set_user
      token = params[:token]
      @member = Member.find_by_token token
      redirect_to public_url if @member.blank?
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
