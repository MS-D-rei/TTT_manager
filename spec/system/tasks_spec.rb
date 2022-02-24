require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:admin_user) { create(:user, name: 'Admin User', email: 'admin@mail.com', admin: true) }
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal@mail.com') }
  let!(:team) { create(:team, leader_id: normal_user.id) }
  let!(:assign) { create(:assign, user_id: admin_user.id, team_id: team.id) }
  let!(:topic) { create(:topic, title: 'First Topic', user_id: normal_user.id, team_id: team.id) }
  let!(:task) { create(:task, title: 'First Task', user_id: normal_user.id, team_id: team.id, topic_id: topic.id) }

  describe '#create' do
    before do
      visit new_user_session_path
      admin_user_log_in
      click_on 'チーム一覧'
      click_on 'First Team'
      click_on 'First Topic'
    end

    context 'user makes a new task' do
      it 'increse the number of tasks by 1' do
        find('#task_title').set('New Task 1')
        find('#task_description').set('New task description')
        find('#task_priority').find("option[value='high']").select_option
        select_date('2022/2/23', from: '期日')
        select_time('18', '00', from: '期日')
        find('#task_status').find("option[value='not_started']").select_option
        expect { click_on 'タスク作成' }.to change { Task.count }.by(1)
      end
    end

    context 'user tries to make a new task without required parameter' do
      it "can't make the new task and will get alert" do
        click_on 'タスク作成'
        expect(page).to have_content 'タスク名と詳細を記入してください'
      end
    end
  end

  describe '#edit' do
    context 'user edit a task parameters ' do
      it 'the parameters will be updated' do
        visit new_user_session_path
        admin_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        click_on 'First Task'
        click_on 'タスク編集'
        find('#task_title').set('Edited Task 1')
        find('#task_description').set('Edited task description')
        find('#task_priority').find("option[value='high']").select_option
        select_date('2022/2/23', from: '期日')
        select_time('18', '00', from: '期日')
        find('#task_status').find("option[value='not_started']").select_option
        click_on 'タスク編集'
        task.reload
        expect(task.title).to eq 'Edited Task 1'
      end
    end
  end

  describe '#destroy' do
    context 'task maker push the delete button' do
      it 'the task will be deleted' do
        visit new_user_session_path
        normal_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        click_on 'First Task'
        page.accept_confirm do
          click_on 'タスク削除'
        end
        sleep(0.5)
        expect(topic.tasks).not_to include task
      end
    end

    context 'user who is not leader and maker access task details' do
      it "can't find the delete button on the screen" do
        visit new_user_session_path
        admin_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        click_on 'First Task'
        expect(page).not_to have_content 'タスク削除'
      end
    end
  end
end
