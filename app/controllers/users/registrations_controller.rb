class Users::RegistrationsController < ApplicationController

  layout 'login'

  def new
    @user = User.new
    @structure = Structure.new
  end

  def create
    #create_user

    @user = User.new(user_params)
    @structure = Structure.new(structure_params)

    @user.structures << @structure

    @user.add_role :admin, @structure

    if @user.save && @structure.save
      redirect_to root_url, notice: 'Un email vient de vous être envoyé contenant les informations nécéssaires à votre inscription.'
    else
      render :new
    end
  end


  private
    def user_params
      params.required(:user).permit(:lastname, :firstname, :email, :password, :password_confirmation)
    end
    def structure_params
      params.required(:structure).permit(:name)
    end
end
