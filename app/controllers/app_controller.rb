class AppController < ApplicationController

  #manage the domain app.

  before_action :set_structure

  private
    def set_structure
      structure_token = cookies.signed[:church_token]

      @structure = Structure.find_by token: structure_token

      if @structure.blank?
        redirect_to structures_url(subdomain: '')
      end
    end

end