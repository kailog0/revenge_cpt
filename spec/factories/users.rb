FactoryBot.define do
  factory :user do
    name { "aoki" }
    password { "aoki_password" }
    admin { "false" }
  end
end
