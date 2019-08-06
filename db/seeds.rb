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

image_class_tags = [
  ["n01440764", Team.first],
  ["n01443537", Team.first],
  ["n01484850", Team.second]
]

image_classes = []

image_class_tags.each_with_index do |item, i|
  image_class = ImageClass.new({id: i+1,
                                tag: item[0],
                                team_id: item[1].id})
  image_class.save!
  image_classes.push(image_class)
end


# Image
fnames_line = []
File.open('db/images.list') { |f|
  f.each_line do |line|
    fnames_line.push(line.chomp)
  end
}

# クラスタ番号も振っておきたい
puts "saving images..."
fnames_line.each do |line|
  class_id_str, class_tag, fname = line.split(",")
  
  Image.create!({url: "/ILSVRC2012_train/#{class_tag}/#{fname}",
                # cluster_no: 1,
                fname: fname,
                image_class_id: image_classes[class_id_str.to_i - 1].id})
end
