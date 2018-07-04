FactoryGirl.define do
  factory :user, aliases: [:owner] do
    first_name 'Aaron'
    last_name 'Sumner'
    sequence(:email) do |n|
      "tester#{n}@example.com"
    end
    password 'dottle-nouveau-pavilion-tights-furze'

    trait :with_projects do
      after(:create) do |user|
        create_list(:project, 2, owner: user)
      end
    end
  end
end
