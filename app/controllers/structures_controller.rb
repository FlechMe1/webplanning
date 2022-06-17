class StructuresController < ApplicationController

  layout 'login'

  def index
    @structures = current_user.structures
  end

  def show
    cookies.signed[:church_token] = {
      value: params[:church_token],
      domain: :all,
      expires: 1.day
    }

    redirect_to app_home_url(subdomain: :app), class: 'Vous êtes arrivé à bon port'
  end

  def new
    @structure = current_user.structures.build
  end

  def create
    @structure = current_user.structures.build(structure_params)

    if current_user.save && @structure.save
      cookies.signed[:church_token] = {
        value: @structure.token,
        domain: :all,
        expires: 1.day
      }

      redirect_to app_home_url(subdomain: :app), class: 'Votre église vient d\'être créée. Félicitations !'
    else
      render :new
    end
  end

  private
    def structure_params
      params.required(:structure).permit(:name)
    end

end