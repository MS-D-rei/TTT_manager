FactoryBot.define do
  factory :task do
    title { 'First task' }
    description { 'First task description' }
    priority { 'high' }
    deadline { Time.zone.now }
    status { 'not_started' }
    user_id { nil }
    team_id { nil }
    topic_id { nil }
  end
end
