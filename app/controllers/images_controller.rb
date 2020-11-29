class ImagesController < ApplicationController
  include Common

  before_action :check_sign_in, only: [:images_tile]


  def new
    image = Image.includes(:annotations).where(annotations: {id: nil}).first
    redirect_to action: "show", id: image.id
  end

  def show
    @image = Image.find(params[:id])
  end

  def update
    ann = Annotation.new(image_id: params[:image_id], label: params[:label],
			 user_id: current_user.id)
    ann.save! 
    redirect_to action: "new"
  end

  def images_tile
    #image_cluster = ImageCluster.find_by(assigned: false, annotated: false)  # TODO 時間がたったらassinedを消すようにしたら修正
    image_cluster = ImageCluster.find_by(annotated: false)

    if image_cluster.nil?
      redirect_to controller: :static_pages, action: :finished
      return
    end

    image_cluster.assigned = true
    image_cluster.team = current_user.team_user.team
    image_cluster.save!

    @image_cluster = ImageCluster.includes(:images).find(image_cluster.id)
  end

  def save_images_tile
    user = User.find_by(email: params["user_email"])

    if user.nil?
      p "error"  # FIXME
    end

    # save annotation
    annotations = []
    labels_data = params["labels_data"]
    labels_data.each do |data|

      image_id = data["image_id"].split("-")[1].to_i
      label = data["label"].to_i

      annotations << Annotation.new(image_id: image_id,
                                    label: label,
                                    user_id: user.id)
    end
    Annotation.import annotations

    image_cluster = ImageCluster.find(params["image_cluster_id"])  # FIXME エラー処理
    image_cluster.annotated = true
    image_cluster.save!

    # dump log
    #log_data_json = {"user_email": user.email,
    #                 "action": "save_images_tile",
    #                 "log": params["log_data"].as_json()}
    #Rails.application.config.annotation_logger.info(log_data_json)  # FIXME 一時的に止める

    render json: [true, {"status": "ok"}]
  end

  def commit_images_tile
    user = User.find_by(email: params["user_email"])

    # TODO userがnilのときの異常処理
    
    # save annotation
    annotations = []
    labels_data = params["labels_data"]
    labels_data.each do |data|
      image_id = data["image_id"].to_i
      label = data["label"].to_i

      annotations << Annotation.new(image_id: image_id,
                                    label: label,
                                    user_id: user.id)
    end
    Annotation.import annotations

    # dump log
    log_data_json = {"user_email": user.email,
                     "action": "save_images_tile",
                     "log": params["log_data"].as_json()}
    Rails.application.config.annotation_logger.info(log_data_json)

    
    # TODO 確定する処理

    render json: [true, {"status": "ok"}]
  end
end
