class EntrancePageController < ApplicationController
  def index
    @running_competition = Competition.
                             where(finished: nil).
                             where('starts_at > ?', Time.current).
                             order('starts_at').
                             first
  end
end
