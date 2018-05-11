30.times do
  Post.create do |post|
    post.title = Faker::Lovecraft.tome
    post.body = Faker::Lovecraft.paragraph
  end
end
