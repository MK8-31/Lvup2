FactoryBot.define do
  factory :user,class: User do
    name {"example user"}
    email {"user@example.com"}
    password {'password'}
    password_confirmation {'password'}
    admin {true}
  end

  factory :other_user,class: User do
    name {"other user"}
    email {"other_user@example.com"}
    password {'password'}
    password_confirmation {'password'}   
  end

  factory :archer,class: User do
    name {"Sterling Archer"}
    email {"aieoiws@example.com"}
    password {'password'}
    password_confirmation {'password'}   
  end

  factory :lana,class: User do
    name {"Lana Kane"}
    email {"ewoaaleiwoi@example.com"}
    password {'password'}
    password_confirmation {'password'}   
  end

    factory :users,class: User do
      name {"Users"}
      email {"users@example.com"}
      password {'password'}
      password_confirmation {'password'}   
    end

end
