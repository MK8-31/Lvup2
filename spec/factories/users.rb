FactoryBot.define do
  factory :user do
    name {"example user"}
    email {"user@example.com"}
    password {'password'}
    password_confirmation {'password'}
    end
end
