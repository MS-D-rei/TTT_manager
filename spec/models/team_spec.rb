require 'rails_helper'

RSpec.describe Team, type: :model do
  let!(:first_user) { FactoryBot.create(:user) }

  describe '#validates' do
    context 'when input name and leader_id properly' do
      let!(:first_team) { FactoryBot.build(:team, leader_id: first_user.id) }
      it 'should be true' do
        expect(first_team.save).to be true
      end
    end

    context 'when no name' do
      let!(:no_name_team) { FactoryBot.build(:team, name: '', leader_id: first_user.id) }
      it 'should be false' do
        expect(no_name_team.save).to be false
      end
    end

    context 'when too long name' do
      let!(:long_name) { ('a' * 51).to_s }
      let!(:long_name_team) { FactoryBot.build(:team, name: long_name, leader_id: first_user.id) }
      it 'should be false' do
        expect(long_name_team.save).to be false
      end
    end

    context 'when no leader_id' do
      let!(:no_leader_team) { FactoryBot.build(:team, leader_id: '') }
      it 'should be false' do
        expect(no_leader_team.save).to be false
      end
    end
  end
end
