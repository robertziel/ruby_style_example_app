FactoryBot.define do
  factory :group_event do
    trait :draft do
      state { GroupEvent::DRAFT }
    end

    trait :published do
      state { GroupEvent::PUBLISHED }
    end

    trait :filled do
      start_date { Time.zone.now }
      end_date { start_date + GroupEvent::DURATION_FACTOR.day }
      duration { GroupEvent::DURATION_FACTOR }

      name { Faker::Lorem.word }
      description { Faker::Lorem.word }
      location { Faker::Lorem.word }
    end
  end
end
