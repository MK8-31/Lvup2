FactoryBot.define do
  factory :orange,class: Micropost do
    content { "MyText orange" }
    created_at { 10.minutes.ago }
    # association :user
  end

  factory :apple,class: Micropost do
    content { "MyText apple" }
    created_at { 3.years.ago }
  end

  factory :run,class: Micropost do
    content { "MyText run" }
    created_at { 2.hours.ago }
  end

  factory :most_recent,class: Micropost do
    content { "MyText most_recent" }
    created_at { Time.zone.now }
  end

  factory :micropost,class: Micropost do
    content {  Faker::Lorem.sentence(word_count: 5) }
    created_at { 1.days.ago }
  end

end
