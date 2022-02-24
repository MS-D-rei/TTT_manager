require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal@mail.com') }
  let!(:team) { create(:team, leader_id: normal_user.id) }
  let!(:assign) { create(:assign, user_id: normal_user.id, team_id: team.id) }
  let!(:topic) { create(:topic, title: 'First Topic', user_id: normal_user.id, team_id: team.id) }
  let!(:first_task) do
    create(:task, title: 'First Task', user_id: normal_user.id, team_id: team.id, topic_id: topic.id)
  end
  let!(:second_task) do
    create(:task, title: 'Second Task', user_id: normal_user.id, team_id: team.id, topic_id: topic.id)
  end
  let!(:bookmark_second_task) { create(:bookmark, user_id: normal_user.id, task_id: second_task.id) }

  describe '#create' do
    context 'user click bookmark button' do
      it 'new bookmark will be created' do
        visit new_user_session_path
        normal_user_log_in
        first('.fa-square').click
        expect(normal_user.bookmarked_tasks).to include first_task
      end
    end
  end

  describe '#show' do
    context 'user click bookmarks header' do
      it 'shows bookmarked_tasks' do
        visit new_user_session_path
        normal_user_log_in
        click_on 'ブックマーク一覧'
        expect(page).to have_content 'Second Task'
      end
    end
  end

  describe '#destroy' do
    context 'user click checked button' do
      it 'delete the bookmark of the task' do
        visit new_user_session_path
        normal_user_log_in
        first('.fa-square-check').click
        expect(normal_user.bookmarked_tasks).not_to include second_task
      end
    end
  end
end
