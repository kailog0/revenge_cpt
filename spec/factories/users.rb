FactoryBot.define do
  factory :user do
    provider { "github" }
    uid { "password_sample" }
    name { "aoki" }
  end
end
