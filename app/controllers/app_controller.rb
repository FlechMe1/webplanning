class AppController < ApplicationController

  #manage the domain app.

  before_action :set_structure

  private
    def set_structure
      @structure = Structure.find cookies.signed[:structure_id]
      if @structure.blank?
        redirect_to structures_path
      end
    end

end