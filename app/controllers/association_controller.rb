class AssociationController < ApplicationController

  before_filter :set_association


  private
    def set_association
      if session[:current_association_id]
        @association = Association.find session[:current_association_id]
      end
    end
end