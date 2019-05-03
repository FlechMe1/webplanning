class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :create_family, only: [:create, :update]

  layout 'public'

  def show
  end

  def new
    @association = Association.find_by_token(params[:token])

    if @association.blank?
      redirect_to root_url, flash:{success: "Le lien est invalide"}
    else
      @member = @association.members.build
      @member.build_sibling
    end

  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to member_path(token: @member.token), notice: 'Votre inscription a été prise en compte'
    else
      render :new
    end
  end

  def edit
    @member.build_sibling if @member.sibling.blank?
    @association = @member.organization
  end

  def update
    @association = @member.organization
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to member_path(token: @member.token), notice: 'Membre mis à jour' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @member.destroy
    redirect_to :members, notice: "Membre supprimé"
  end

  private
    def set_member
      @member = Member.find_by_token params[:token]
    end

    def member_params
      params.required(:member).permit(:gender, :firstname, :lastname, :birthdate, :email, :phone_1,
                                      :phone_2, :address_1, :cgu, :category, :association_id,
                                       :user_id, :address_2, :zipcode, :town, sibling_attributes: [:family_id, :status])
    end

    def create_family
      if params[:member] && params[:member][:sibling_attributes] && params[:member][:sibling_attributes][:family_id] == 'new_family'
        @family = @association.families.build(name: params[:member][:lastname])
        @family.email = params[:member][:email]
        @family.phone_1 = params[:member][:phone_1]
        @family.address_1 = params[:member][:address_1]
        @family.address_2 = params[:member][:address_2]
        @family.zipcode = params[:member][:zipcode]
        @family.town = params[:member][:town]
        @family.association_id = params[:member][:association_id]
        @family.save

        params[:member][:sibling_attributes][:family_id] = @family.id
      end
    end
end