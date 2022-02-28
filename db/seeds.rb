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
5.times do |n|
  name = "Team #{n + 1}"
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
description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 Integer feugiat scelerisque gravida. Phasellus a turpis porttitor arcu porta tristique.
  Vestibulum semper molestie fringilla. Aliquam aliquet leo lectus,
   eget semper felis posuere sed. Aliquam eleifend blandit sodales.
    Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;
     Aliquam a est pharetra, hendrerit sem vitae, finibus mauris.
      Ut malesuada rhoncus risus, sit amet pretium urna. Donec porttitor vehicula enim,
       eget vulputate orci dignissim et. Sed in tortor vestibulum, rhoncus ligula nec, consequat erat.'
3.times do |n|
  topic_title = "Topic title #{n + 1}"
  topic_description = description
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
    3.times do |i|
      task_title = "Task title #{i + 1}"
      task_description = description
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

# Bookmark creation
10.times do
  user_id = rand(1..2)
  task_id = rand(1..20)
  while Bookmark.find_by(user_id: user_id, task_id: task_id)
    user_id = rand(1..2)
    task_id = rand(1..20)
  end
  Bookmark.create!(
    user_id: user_id,
    task_id: task_id
  )
end
