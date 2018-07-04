FactoryGirl.define do
  factory :project do
    sequence(:name) do |n|
      "Test Project #{n}"
    end
    description 'Sample project for testing purposes'
    due_on 1.week.from_now
    association :owner

    trait :with_notes do
      after(:create) do |project|
        create_list(:note, 5, project: project)
      end
    end

    # 締め切りが昨日
    trait :due_yesterday do
      due_on 1.day.ago
    end

    # 締め切りが今日
    trait :due_today do
      due_on Date.current.in_time_zone
    end

    # 締め切りが明日
    trait :due_tomorrow do
      due_on 1.day.from_now
    end

    # # 昨日が締め切りのプロジェクト
    # factory :project_due_yesterday do
    #   due_on 1.day.ago
    # end
    #
    # # 今日が締め切りのプロジェクト
    # factory :project_due_today do
    #   due_on Date.current.in_time_zone
    # end
    #
    # # 明日が締め切りのプロジェクト
    # factory :project_due_tomorrow, class: Project do
    #   due_on 1.day.from_now
    # end
  end
end