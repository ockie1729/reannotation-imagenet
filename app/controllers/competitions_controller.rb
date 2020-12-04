class CompetitionsController < ApplicationController
  
  def next
    next_competition = Competition.
                         where(finished: nil).
                         where('starts_at > ?', Time.current).
                         order('starts_at').
                         first
    res =  {starts_at: next_competition.starts_at.to_s,
            ends_at: next_competition.ends_at.to_s}
    
    render json: res
  end
end
