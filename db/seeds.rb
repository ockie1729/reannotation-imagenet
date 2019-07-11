# add sample images
500.times do |n|
   Image.create!(url: "/cats_and_dogs/#{n+1}.jpg")
end
