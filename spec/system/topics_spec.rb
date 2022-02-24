require 'rails_helper'

RSpec.describe 'Topics', type: :system do
  let!(:admin_user) { create(:user, name: 'Admin User', email: 'admin@mail.com', admin: true) }
  let!(:normal_user) { create(:user, name: 'Normal User', email: 'normal@mail.com') }
  let!(:team) { create(:team, name: 'First Team', leader_id: normal_user.id) }
  let!(:topic) { create(:topic, title: 'First Topic', user_id: normal_user.id, team_id: team.id) }

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

    context 'member create new topic' do
      it 'the team has the new topic' do
        visit new_user_session_path
        admin_user_log_in
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

  describe '#show' do
    context 'member click the topic name in the team show view' do
      it 'show topic details and edit button' do
        visit new_user_session_path
        admin_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        expect(page).to have_content topic.description
        expect(page).to have_content 'トピック編集'
      end
    end
  end

  describe '#edit' do
    context 'user edit the topic parameters' do
      it 'can update them' do
        visit new_user_session_path
        admin_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        click_on 'トピック編集'
        find('#topic_title').set('Edited Topic 1')
        find('#topic_description').set('Edited topic description')
        find('#topic_priority').find("option[value='high']").select_option
        select_date('2022/2/23', from: '期日')
        select_time('18', '00', from: '期日')
        find('#topic_status').find("option[value='not_started']").select_option
        click_on 'トピック更新'
        topic.reload
        expect(topic.title).to eq 'Edited Topic 1'
      end
    end

    context 'user edit the topic without description' do
      it "can't update the topic and get alert" do
        visit new_user_session_path
        admin_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        click_on 'トピック編集'
        find('#topic_title').set('Edited Topic 1')
        find('#topic_description').set('')
        find('#topic_priority').find("option[value='high']").select_option
        select_date('2022/2/23', from: '期日')
        select_time('18', '00', from: '期日')
        find('#topic_status').find("option[value='not_started']").select_option
        click_on 'トピック更新'
        topic.reload
        expect(topic.description).to eq 'First description'
        expect(page).to have_content 'トピックの更新に失敗しました'
      end
    end
  end

  describe '#destroy' do
    context 'leader or topic maker delete the topic' do
      it 'the topic will be deleted' do
        visit new_user_session_path
        normal_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        click_on 'First Topic'
        page.accept_confirm do
          click_on '削除'
        end
        sleep(0.5)
        expect(team.topics).not_to include topic
      end
    end

    context "member who is not the topic maker tries to edit topic" do
      it "can't find delete button in the view" do
        visit new_user_session_path
        admin_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        expect(page).not_to have_content 'トピック削除'
      end
    end
  end
end
