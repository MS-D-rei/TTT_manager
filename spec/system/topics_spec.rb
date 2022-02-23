require 'rails_helper'

RSpec.describe 'Topics', type: :system do
  let!(:admin_user) { create(:user, name: 'Admin User', email: 'admin@mail.com', admin: true) }
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal@mail.com') }
  let!(:team) { create(:team, name: 'First Team', leader_id: normal_user.id) }

  describe '#create' do
    context 'leader create new topic' do
      it 'the team has the new topic' do
        visit new_user_session_path
        normal_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        find('#topic_title').set('New Topic 1')
        find('#topic_description').set('New topic description')
        find('#topic_priority').find("option[value='high']").select_option
        select_date('2022/2/23', from: '期日')
        select_time('18', '00', from: '期日')
        find('#topic_status').find("option[value='not_started']").select_option
        click_on 'トピック作成'
        expect(page).to have_content 'New Topic 1'
      end
    end
  end
end
