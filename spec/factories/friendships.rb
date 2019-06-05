FactoryBot.define do
  factory :friendship do
    association :active_friend, factory: :user
    association :passive_friend, factory: :user
  end
end