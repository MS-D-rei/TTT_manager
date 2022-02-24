require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:admin_user) { create(:user, name: 'Admin User', email: 'admin1@mail.com', admin: true) }
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal1@mail.com') }
  let!(:team) { create(:team, leader_id: normal_user.id) }
  let!(:assign) { create(:assign, user_id: normal_user.id, team_id: team.id) }
  let!(:topic) { create(:topic, title: 'First Topic', user_id: normal_user.id, team_id: team.id) }
  let!(:first_task) do
    create(:task, title: 'First Task', user_id: normal_user.id, team_id: team.id, topic_id: topic.id)
  end
  let!(:second_task) do
    create(:task, title: 'Second Task', priority: 'middle', user_id: normal_user.id, team_id: team.id, topic_id: topic.id)
  end

  describe '#registration' do
    context 'create new account' do
      it 'increase the number of users by 1' do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'New User 1'
        fill_in 'user[email]', with: 'new1@mail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        expect { click_on 'アカウント登録' }.to change { User.count }.by(1)
      end
    end
  end

  describe '#login' do
    context 'normal user login' do
      it "show normal user's related tasks" do
        visit new_user_session_path
        normal_user_log_in
        sleep(0.5)
        expect(page).to have_content 'Normal User'
      end
    end
  end

  describe '#update' do
    before do
      visit new_user_session_path
      normal_user_log_in
      sleep(0.5)
      visit edit_user_registration_path(normal_user)
      sleep(0.5)
    end

    context "update user's profile" do
      it 'change name, email, password' do
        fill_in 'user[name]', with: 'Edited User Name'
        fill_in 'user[email]', with: 'edited@mail.com'
        fill_in 'user[password]', with: 'changepassword'
        fill_in 'user[password_confirmation]', with: 'changepassword'
        fill_in 'user[current_password]', with: 'password'
        click_on '更新'
        normal_user.reload
        expect(normal_user.name).to eq 'Edited User Name'
        expect(normal_user.email).to eq 'edited@mail.com'
        expect(normal_user.valid_password?('changepassword')).to be_truthy
      end
    end

    context 'input incorrect current_password' do
      it "can't update user profile" do
        fill_in 'user[name]', with: 'Edited User Name'
        fill_in 'user[email]', with: 'edited@mail.com'
        fill_in 'user[password]', with: 'changepassword'
        fill_in 'user[password_confirmation]', with: 'changepassword'
        fill_in 'user[current_password]', with: 'incorrect'
        click_on '更新'
        normal_user.reload
        expect(normal_user.name).not_to eq 'Edited User Name'
        expect(normal_user.email).not_to eq 'edited@mail.com'
        expect(normal_user.valid_password?('changepassword')).to be_falsy
      end
    end
  end

  describe "#admin page access" do
    context 'admin user access admin page' do
      it 'show admin user index' do
        visit new_user_session_path
        admin_user_log_in
        sleep(0.5)
        click_on '管理者画面'
        expect(page).to have_content 'サイト管理'
      end
    end

    context 'normal user tries to access admin page' do
      it "can't access admin page and get alert" do
        visit new_user_session_path
        normal_user_log_in
        sleep(0.5)
        visit rails_admin_path
        expect(page).to have_content 'Access denied, only admin user can access admin pages'
      end
    end
  end

  describe '#ransack' do
    before do
      visit new_user_session_path
      normal_user_log_in
    end

    context 'user click search button without parameters' do
      it 'shows all tasks the user maked' do
        click_on '検索'
        expect(page).to have_content 'First Task'
        expect(page).to have_content 'Second Task'
      end
    end

    context 'user input task title and click search button' do
      it 'shows the task which have the title' do
        find('#q_title_cont').set('Second')
        click_on '検索'
        expect(page).to have_content 'Second Task'
      end
    end

    context 'user select priority and click search button' do
      it 'shows the task which have the priority' do
        choose 'q_priority_eq_0' # high
        click_on '検索'
        expect(page).to have_content 'First Task'
      end
    end

    context 'user input task title and select priority and then click search button' do
      it 'shows the task which have the task title and priority' do
        find('#q_title_cont').set('Second')
        choose 'q_priority_eq_1' # middle
        click_on '検索'
        expect(page).to have_content 'Second Task'
      end
    end
  end
end
