class EntrancePageController < ApplicationController
  def index
    # 開催中のコンペがあったら，コンペページに遷移
    # 注意: ここの条件をミスると，コンペページとここのあいだを無限に遷移
    running_competition = Competition.
                            where(finished: nil).
                            where('starts_at <= ?', Time.current).
                            where('ends_at > ?', Time.current).
                            first
    if running_competition
      redirect_to root_path
    end

    # 次のコンペの情報を表示
    @next_competition = Competition.
                          where(finished: nil).
                          where('starts_at > ?', Time.current).
                          order('starts_at').
                          first
  end
end
