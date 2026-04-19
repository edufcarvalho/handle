# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    id { "" }
    type { "" }
    description { "MyString" }
    due_date { "2026-04-18 23:51:02" }
    priority { "MyString" }
    title { "MyString" }
    workstream { nil }
  end
end
