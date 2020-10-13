FactoryBot.define do
  factory :group_event do
    trait :draft do
      state { GroupEvent::DRAFT }
    end

    trait :published do
      state { GroupEvent::PUBLISHED }
    end

    trait :filled do
      start_date { Faker::Date.in_date_period }
      end_date { start_date + GroupEvent::DURATION_FACTOR.days }
      duration { GroupEvent::DURATION_FACTOR }

      name { Faker::Lorem.word }
      description { Faker::Lorem.word }
      location { Faker::Lorem.word }
    end
  end
end
