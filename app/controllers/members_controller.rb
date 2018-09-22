class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :create_family, only: [:create, :update]

  def index
    @members = Member.order('lastname ASC').paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @user = @member.user
    if @user.blank?
      @match = User.find_by_email(@member.email) if @member.email?
    end
  end

  def new
    @member = Member.new
    @member.build_sibling
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to :members, notice: 'Un nouveau membre a été ajouté'
    else
      render :new
    end
  end

  def edit
    @member.build_sibling if @member.sibling.blank?
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Membre mis à jour' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  private
    def set_member
      @member = Member.find params[:id]
    end

    def member_params
      params.required(:member).permit(:gender, :firstname, :lastname, :birthdate, :email, :phone_1,
                                      :phone_2, :address_1, :cgu, :category,
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

        puts @family.inspect

        params[:member][:sibling_attributes][:family_id] = @family.id
      end
    end
end