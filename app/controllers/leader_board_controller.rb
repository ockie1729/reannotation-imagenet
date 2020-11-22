class LeaderBoardController < ApplicationController
  def index
    @users = User.all.left_joins(:annotations)
               .group(:id)
               .select('users.name, COUNT(`annotations`.`id`) as count_annotations_id')
               .order('count_annotations_id desc')
 end
end
