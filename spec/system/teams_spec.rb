require 'rails_helper'

RSpec.describe 'Teams', type: :system do
  let!(:normal_user) { create(:user, name: 'Normal User') }
  let!(:team) { create(:team, name: 'First Team', leader_id: normal_user.id) }

  describe '#new' do
    before do
      visit new_user_session_path
      normal_user_log_in
      click_on 'チーム一覧'
    end
    context 'user create new team' do
      it "increase the number of teams by 1 and it's leader is normal_user" do
        find('#team_name').set('New Team 1')
        expect { click_on 'チーム作成' }.to change { Team.count }.by(1)
        expect(Team.last.leader).to eq normal_user
      end
    end

    context 'input no team name' do
      it "can't create a new team" do
        find('#team_name').set('')
        expect { click_on 'チーム作成' }.to change { Team.count }.by(0)
      end
    end
  end

  describe '#update' do
    context 'change team name' do
      it 'the team has the changed name' do
        visit new_user_session_path
        normal_user_log_in
        click_on 'チーム一覧'
        click_on 'First Team'
        find('#team_name').set('Edited Team')
        click_on 'チーム名更新'
        team.reload
        expect(Team.find(team.id).name).to eq 'Edited Team'
      end
    end
  end

  describe '#destroy' do
    before do
      visit new_user_session_path
      normal_user_log_in
      click_on 'チーム一覧'
      click_on 'First Team'
    end

    context 'the team has no topic' do
      it 'leader can delete the team' do
        page.accept_confirm do
          click_on '解散'
        end
        expect(page).to have_content 'チームを解散しました'
      end
    end

    context 'the team has one topic' do
      let!(:topic) { create(:topic, user_id: normal_user.id, team_id: team.id) }
      it "leader can't delete the team" do
        page.accept_confirm do
          click_on '解散'
        end
        expect(page).to have_content 'トピックのあるチームは解散できません'
      end
    end
  end
end
