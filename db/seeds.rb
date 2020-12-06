# 2020-11-29
#
# ILSVRC2012 trainの最後の二クラスを登録

# User
puts "saving users..."
user1 = User.new(name: "kataoka-san",
                 email: "kataoka@cv.com",
                 password: "password")
user1.save!

user2 = User.new(name: "ryota-sensei",
                 email: "ryota@cv.com",
                 password: "password")
user2.save!

user3 = User.new(name: "okimoto",
                 email: "okimoto@cv.com",
                 password: "password")
user3.save!

user4 = User.new(name: "saeki",
                 email: "saeki@cv.com",
                 password: "password")
user2.save!

# ImageClass
puts "saving image class..."

image_class_tags = ["n13133613", "n15075141"]

image_classes = []

image_class_tags.each_with_index do |tag, i|
  image_class = ImageClass.new({id: i+1,
                                tag: tag})
  image_class.save!
  image_classes.push(image_class)
end

# Image Cluster
puts "saving image cluster..."

# class1に紐づくものを99作る
99.times do
  image_cluster = ImageCluster.new({image_class_id: 1})
  image_cluster.save!
end

# class2に紐づくものを260作る
260.times do
  image_cluster = ImageCluster.new({image_class_id: 2})
  image_cluster.save!  
end

# Image
fnames_line = []
File.open('db/ILSVRC2012_train_last_2_classes.list') { |f|
  f.each_line do |line|
    fnames_line.push(line.chomp)
  end
}

puts "saving images..."
fnames_line.each do |line|
  class_id_str, cluster_id_str, url = line.split(",")

  Image.create!({url: url,
                 fname: url.split("/").last,
                 image_class_id: class_id_str.to_i,
                 image_cluster_id: cluster_id_str.to_i})
end
