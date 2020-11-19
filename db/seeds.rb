# Team
puts "saving teams..."

5.times do
  Team.create!()
end

# User
puts "saving users..."
user1 = User.new(name: "kataoka-san",
                 email: "kataoka@cv.com",
                 password: "password")
user1.save!
TeamUser.create!(user: user1,
                 team: Team.first)


user2 = User.new(name: "ryota-sensei",
                 email: "ryota@cv.com",
                 password: "password")
user2.save!
TeamUser.create!(user: user2,
                 team: Team.first)


user3 = User.new(name: "okimoto",
                 email: "okimoto@cv.com",
                 password: "password")
user3.save!
TeamUser.create!(user: user3,
                 team: Team.second)

user4 = User.new(name: "saeki",
                 email: "saeki@cv.com",
                 password: "password")
user2.save!
TeamUser.create!(user: user4,
                 team: Team.second)

# ImageClass
# これは予め出来る
# 予めクラスのタイプを見て，チームを割振っておく
puts "saving image class..."

# image_class_tags = [
#   ["n01440764", Team.first],
#   ["n01443537", Team.first],
#   ["n01484850", Team.second]
# ]
image_class_tags = ["cat", "dog"]

image_classes = []

image_class_tags.each_with_index do |tag, i|
  image_class = ImageClass.new({id: i+1,
                                tag: tag})
  image_class.save!
  image_classes.push(image_class)
end

# Image Cluster
image_clusters = [2, 2, 1, 1]

image_clusters.each_with_index do |image_class_id, i|
  image_cluster = ImageCluster.new({id: i+1,
                                    image_class_id: image_class_id})
  image_cluster.save!
end

# TODO まずはcats_and_dogsの画像を表示

# ILSVRC2012の画像の表示は一旦コメントアウト
# # Image
# fnames_line = []
# File.open('db/images.list') { |f|
#   f.each_line do |line|
#     fnames_line.push(line.chomp)
#   end
# }

# # TODO クラスタ番号も振っておきたい
# puts "saving images..."
# fnames_line.each do |line|
#   class_id_str, class_tag, fname = line.split(",")
  
#   Image.create!({url: "/ILSVRC2012_train/#{class_tag}/#{fname}",
#                 # cluster_no: 1,
#                 fname: fname,
#                 image_class_id: image_classes[class_id_str.to_i - 1].id})
# end


# Image
fnames_line = []
File.open('db/cats_and_dogs_selected.list') { |f|
  f.each_line do |line|
    fnames_line.push(line.chomp)
  end
}

puts "saving images..."
fnames_line.each do |line|
  class_id_str, cluster_id_str, fname = line.split(",")

  Image.create!({url: "/cats_and_dogs/#{fname}",
                 fname: fname,
                 image_class_id: image_classes[class_id_str.to_i - 1].id,
                 image_cluster_id: cluster_id_str.to_i})
end
