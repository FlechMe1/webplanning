class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.order('lastname ASC').paginate(:page => params[:page], :per_page => 25)
  end

  def edit
  end

  private
    def set_member
      @member = Member.find params[:id]
    end
end