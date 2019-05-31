FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user { FactoryBot.create(:user) }
    post { FactoryBot.create(:post) }
  end
end
