# users creation
User.create!(
  name: 'Test Name',
  email: 'test@mail.com',
  password: 'password',
  admin: true
)

10.times do |n|
  name = Faker::Name.name
  email = "test-#{n + 1}@mail.com"
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password
  )
end

# teams creation
5.times do
  name = Faker::Lorem.sentence(word_count: 1)
  Team.create!(
    name: name,
    leader_id: rand(1..5)
  )
end

# assigns creation
Assign.create!(
  user_id: 1,
  team_id: 1
)

20.times do
  user_id = rand(1..10)
  team_id = rand(1..5)
  while Assign.find_by(user_id: user_id, team_id: team_id)
    user_id = rand(1..10)
    team_id = rand(1..5)
  end
  Assign.create!(
    user_id: user_id,
    team_id: team_id
  )
end

# topics and tasks creation
users = User.all
3.times do |n|
  topic_title = Faker::Lorem.sentence(word_count: 2)
  topic_description = Faker::Lorem.sentence(word_count: 50)
  topic_priority = rand(0..2)
  topic_deadline = Time.zone.now + 60 * 60 * 24 * (n + 1)
  topic_status = rand(0..2)
  team_id = rand(1..5)
  users.each do |user|
    topic = user.topics.create!(
      title: topic_title,
      description: topic_description,
      priority: topic_priority,
      deadline: topic_deadline,
      status: topic_status,
      team_id: team_id
    )
    topic_id = topic.id
    3.times do
      task_title = Faker::Lorem.sentence(word_count: 2)
      task_description = Faker::Lorem.sentence(word_count: 50)
      task_priority = rand(0..2)
      task_deadline = Time.zone.now + 60 * 60 * 24 * (n + 1)
      task_status = topic_status
      user.tasks.create!(
        title: task_title,
        description: task_description,
        priority: task_priority,
        deadline: task_deadline,
        status: task_status,
        team_id: team_id,
        topic_id: topic_id
      )
    end
  end
end
