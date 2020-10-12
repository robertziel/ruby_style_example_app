FactoryBot.define do
  factory :group_event do
    trait :draft do
      state { GroupEvent::DRAFT }
    end

    trait :published do
      state { GroupEvent::PUBLISHED }
    end
  end
end
