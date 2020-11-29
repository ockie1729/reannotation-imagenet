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

  def check_competition_running
    # FIXME 開始しているコンペが無いときのみリダイレクトするよう修正
    if Time.current.to_a[1] % 2 == 0
      redirect_to "/entrance_page/index"
    end
  end
end
