class Users::SessionsController < Devise::SessionsController

  layout 'login'
  before_action :delete_structure_cookie, only: :destroy


  private
    def delete_structure_cookie
      cookies.delete :church_token, domain: :all
    end

end
