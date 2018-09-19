class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :create_family, only: [:create, :update]

  def index
    @members = Member.order('lastname ASC').paginate(:page => params[:page], :per_page => 25)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    @member.family_id = @family.id if @family

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
    if @member.update(member_params)
      redirect_to :members, notice: 'Membre mis à jour'
    else
      render :edit
    end
  end

  private
    def set_member
      @member = Member.find params[:id]
    end

    def member_params
      params.required(:member).permit(:gender, :firstname, :lastname, :email, :phone_1, :phone_2, :address_1,
                                        :address_2, :zipcode, :town, sibling_attributes: [:family_id, :status])
    end

    def create_family
      if params[:member] && params[:member][:sibling] && params[:member][:sibling][:family_id] == 'new_family'
        @family = Family.find_or_create_by(name: params[:member][:lastname])
        @family.email = params[:member][:email]
        @family.phone_1 = params[:member][:phone_1]
        @family.address_1 = params[:member][:address_1]
        @family.address_2 = params[:member][:address_2]
        @family.zipcode = params[:member][:zipcode]
        @family.town = params[:member][:town]
        @family.save

        params[:member][:sibling][:family_id] = @family.id
      end
    end
end