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
      end_date { start_date + 30.day }
      duration { 30 }

      name { 'example_name' }
      description { 'example_description' }
      location { 'example_location' }
    end
  end
end
