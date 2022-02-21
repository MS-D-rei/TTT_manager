FactoryBot.define do
  factory :topic do
    title { 'First Topic' }
    description { 'First description' }
    priority { 'high' }
    deadline { Time.zone.now }
    status { 'not_started' }
    user_id { nil }
    team_id { nil }
  end
end
