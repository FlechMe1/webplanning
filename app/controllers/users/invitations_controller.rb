class Users::InvitationsController < Devise::InvitationsController

  private
  def resource_params
    params.permit(user: [:firstname, :lastname, :email, :password, :password_confirmation, :invitation_token])[:user]
  end
end
