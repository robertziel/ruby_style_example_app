FactoryBot.define do
  factory :group_event do
    trait :draft do
      state { GroupEvent::DRAFT }
    end

    trait :published do
      state { GroupEvent::PUBLISHED }
    end

    trait :filled do
      duration { GroupEvent::DURATION_FACTOR }
      start_date { Faker::Date.in_date_period }
      end_date do
        if start_date
          StartEndDurationService.call(
            start_date: start_date,
            duration: GroupEvent::DURATION_FACTOR
          )[:end_date]
        else
          Faker::Date.in_date_period
        end
      end

      name { Faker::Lorem.word }
      description { Faker::Lorem.word }
      location { Faker::Lorem.word }
    end
  end
end
