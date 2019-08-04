# add sample images
fnames = []

File.open('db/images.list') { |f|
  f.each_line do |line|
    fnames.push(line.chomp)
  end
}

fnames.each do |fname|
  Image.create!(url: "https://s3-ap-northeast-1.amazonaws.com/ilsvrc2012-train-n1/#{fname}")
end
