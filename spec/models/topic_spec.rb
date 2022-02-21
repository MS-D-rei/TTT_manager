require 'rails_helper'

RSpec.describe Topic, type: :model do
  let!(:user) { create(:user) }
  let!(:team) { create(:team, leader_id: user.id) }

  describe '#validates' do
    context 'when input parameters properly' do
      let!(:proper_topic) { build(:topic, user_id: user.id, team_id: team.id) }
      it 'should be true' do
        expect(proper_topic.save).to be_truthy
      end
    end

    context 'when no title' do
      let!(:no_title_topic) { build(:topic, title: '', user_id: user.id, team_id: team.id) }
      it 'should be false' do
        expect(no_title_topic.save).to be_falsy
      end
    end

    context 'when long title over 200 chars' do
      let!(:too_long_title) { ('a' * 201).to_s }
      let!(:long_title_topic) do
        build(:topic, title: too_long_title, user_id: user.id, team_id: team.id)
      end
      it 'should be false' do
        expect(long_title_topic.save).to be_falsy
      end
    end

    context 'when no description' do
      let!(:no_description_topic) do
        build(:topic, description: '', user_id: user.id, team_id: team.id)
      end
      it 'should be false' do
        expect(no_description_topic.save).to be_falsy
      end
    end

    context 'when too long description over 1,000 chars' do
      let!(:too_long_description) { ('a' * 1001).to_s }
      let!(:long_descripiton_topic) do
        build(:topic, description: too_long_description, user_id: user.id, team_id: team.id)
      end
      it 'should be false' do
        expect(long_descripiton_topic.save).to be_falsy
      end
    end

    context 'when no priority' do
      let!(:no_priority_topic) do
        build(:topic, priority: '', user_id: user.id, team_id: team.id)
      end
      it 'should be false' do
        expect(no_priority_topic.save).to be_falsy
      end
    end

    context 'when no deadline' do
      let!(:no_deadline_topic) do
        build(:topic, deadline: '', user_id: user.id, team_id: team.id)
      end
      it 'should be false' do
        expect(no_deadline_topic.save).to be_falsy
      end
    end

    context 'when no status' do
      let!(:no_status_topic) do
        build(:topic, status: '', user_id: user.id, team_id: team.id)
      end
      it 'should be false' do
        expect(no_status_topic.save).to be_falsy
      end
    end

    context 'when no user_id' do
      let!(:no_user_id_topic) { build(:topic, team_id: team.id) }
      it 'should be false' do
        expect(no_user_id_topic.save).to be_falsy
      end
    end

    context 'when no team_id' do
      let!(:no_team_id_topic) { build(:topic, user_id: user.id) }
      it 'should be false' do
        expect(no_team_id_topic.save).to be_falsy
      end
    end
  end
end
