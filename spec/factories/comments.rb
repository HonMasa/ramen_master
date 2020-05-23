FactoryBot.define do
  factory :comment do
    content { 'testcomment' }
    association :post
    user { post.owner }
  end
end
