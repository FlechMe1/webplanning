class Users::InvitationsController < Devise::InvitationsController

  before_filter :set_association, only: [:new, :create]
  before_filter :update_sanitized_params, only: :update

  def create
    self.resource = User.invite!(invite_params, current_user)
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      resource.associations << @association
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      redirect_to [:association, :users], notice: "L\'invitation a été envoyée"
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update_attributes update_resource_params.except(:invitation_token)
      end
      format.html do
        super
      end
    end
  end


  private
    def update_sanitized_params
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:firstname, :lastname, :password, :password_confirmation, :invitation_token])
    end

    def invite_params
      params.required(:user).permit(:firstname, :lastname, :email)
    end

    def set_association
      if session[:current_association_id]
        @association = Association.find session[:current_association_id]
      end
    end
end
