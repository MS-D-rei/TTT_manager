require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:admin_user) { create(:user, name: 'Admin User', email: 'admin1@mail.com', admin: true) }
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal1@mail.com') }

  # skip for now
  xdescribe '#new' do
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

  # describe '#login' do
  #   context 'normal user login' do
  #     it "show normal user's related tasks" do
  #       visit new_user_session_path
  #       normal_user_log_in
  #       sleep(0.5)
  #       expect(page).to have_content 'Normal User'
  #     end
  #   end
  # end

  describe '#update' do
    context "update user's profile" do
      it 'change name, email, password' do
        visit new_user_session_path
        normal_user_log_in
        sleep(0.5)
        visit edit_user_registration_path(normal_user)
        sleep(0.5)
        fill_in 'user[name]', with: 'Edited User Name'
        fill_in 'user[email]', with: 'edited@mail.com'
        fill_in 'user[password]', with: 'changepassword'
        fill_in 'user[password_confirmation]', with: 'changepassword'
        fill_in 'user[current_password]', with: 'password'
        click_on '更新'
        sleep(0.5)
        expect(normal_user.name).to eq 'Edited User Name'
        expect(normal_user.email).to eq 'edited@mail.com'
        expect(normal_user.password).to eq 'changepassword'
      end
    end
  end
end
