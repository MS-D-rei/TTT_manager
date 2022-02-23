require 'rails_helper'

RSpec.describe 'Assigns', type: :system do
  let!(:admin_user) { create(:user, name: 'Admin User', admin: true) }
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal@mail.com') }
  let!(:team) { create(:team, name: 'First Team', leader_id: normal_user.id) }

  describe '#create' do
    before do
      visit new_user_session_path
      normal_user_log_in
      click_on 'チーム一覧'
      click_on 'First Team'
    end
    context 'user invite other user to a team' do
      it 'other user will be a member' do
        find('#assign_user_id').find("option[value='#{admin_user.id}']").select_option
        expect { click_on '招待' }.to change { team.members.count }.by(1)
      end
    end

    context "user didn't select any user to invite" do
      it 'raise a notification, please select member to invite' do
        click_on '招待'
        expect(page).to have_content '招待するメンバーを選択してください'
      end
    end
  end

  describe '#destroy' do
    context 'leader push drop button to get a member depart from the team' do
      it 'the member will not be a member of the team' do
        visit new_user_session_path
        normal_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        find('#assign_user_id').find("option[value='#{admin_user.id}']").select_option
        click_on '招待'
        click_on '離脱'
        expect(team.members).not_to include admin_user
      end
    end
  end
end
