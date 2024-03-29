class App::MembersController < AppController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :create_family, only: [:create, :update]
  before_action :set_categores, only: [:new, :create, :edit, :update]

  def index
    @members = @structure.members.order('lastname ASC').paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @user = @member.user
    if @user.blank?
      @match = User.find_by_email(@member.email) if @member.email?
    end
  end

  def new
    @member = @structure.members.build
    @member.build_sibling
  end

  def create
    @member = @structure.members.build(member_params)

    if @member.save
      redirect_to [:app, :members], notice: 'Un nouveau membre a été ajouté'
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
        format.html { redirect_to [:app, @member], notice: 'Membre mis à jour' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @member.destroy
    redirect_to [:app, :members], notice: "Membre supprimé"
  end

  private
    def set_member
      @member = Member.find params[:id]
    end

    def member_params
      params.required(:member).permit(:gender, :firstname, :lastname, :birthdate, :email, :phone_1,
                                      :phone_2, :address_1, :cgu, :category,
                                       :user_id, :address_2, :zipcode, :town, sibling_attributes: [:id, :family_id, :status], category_ids: [])
    end

    def set_categores
      @categories = @structure.categories.order(name: :asc)
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
        @family.structure_id = @structure.id
        @family.save


        params[:member][:sibling_attributes][:family_id] = @family.id
      end
    end
end