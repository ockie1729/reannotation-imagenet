module Common
  extend ActiveSupport::Concern

  def check_sign_in
     if current_user.nil?
       redirect_to "/users/sign_in"
       return
     end

     if current_user.team_user.nil?
       redirect_to "/static_pages/index"
       return
     end
  end
end
