require 'rails_helper'

RSpec.describe Assign, type: :model do
  let!(:first_user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:user, name: 'Secound User', email: 'second@mail.com') }
  let!(:first_team) { FactoryBot.create(:team, leader_id: first_user.id) }

  describe '#validate' do
    context 'a user is assigned to a team' do
      let!(:first_assign) { FactoryBot.build(:assign, user_id: first_user.id, team_id: first_team.id) }
      it 'should be true' do
        expect(first_assign.save).to be_truthy
      end
    end

    context 'when no user_id' do
      let!(:no_user_assign) { FactoryBot.build(:assign, team_id: first_team.id) }
      it 'should be false' do
        expect(no_user_assign.save).to be_falsy
      end
    end

    context 'when no team_id' do
      let!(:no_team_assign) { FactoryBot.build(:assign, user_id: first_user.id) }
      it 'should be false' do
        expect(no_team_assign.save).to be_falsy
      end
    end

    context 'when uesr_id/team_id combination is not unique' do
      let!(:first_assign) { FactoryBot.create(:assign, user_id: first_user.id, team_id: first_team.id) }
      let!(:already_assign) { FactoryBot.build(:assign, user_id: first_user.id, team_id: first_team.id) }
      it 'should be false' do
        expect(already_assign.save).to be_falsy
      end
    end
  end
end
