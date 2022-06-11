class StructuresController < ApplicationController

  layout 'login'

  def index
    @structures = current_user.structures
  end

  def show
    structure_id = EncryptionService.decrypt(params[:encrypted_id])
    cookies.signed[:structure_id] = structure_id

    redirect_to app_home_url(subdomain: :app), class: 'Vous êtes arrivé à bon port'
  end

end