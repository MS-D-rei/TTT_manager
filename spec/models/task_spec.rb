require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:team) { FactoryBot.create(:team, leader_id: user.id) }
  let!(:topic) { FactoryBot.create(:topic, user_id: user.id, team_id: team.id) }

  describe '#validates' do
    context 'when input parameters properly' do
      let!(:proper_task) do
        build(:task, user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be true' do
        expect(proper_task.save).to be_truthy
      end
    end

    context 'when no title' do
      let!(:no_title_task) do
        build(:task, title: '', user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(no_title_task.save).to be_falsy
      end
    end

    context 'when too long title over 200 chars' do
      let!(:too_long_title) { ('a' * 201).to_s }
      let!(:long_title_task) do
        build(:task, title: too_long_title, user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(long_title_task.save).to be_falsy
      end
    end

    context 'when no description' do
      let!(:no_description_topic) do
        build(:task, description: '', user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(no_description_topic.save).to be_falsy
      end
    end

    context 'when too long description over 1000 chars' do
      let!(:too_long_description) { ('a' * 1001).to_s }
      let!(:long_description_task) do
        build(:task, description: too_long_description, user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(long_description_task.save).to be_falsy
      end
    end

    context 'when no priority' do
      let!(:no_priority_task) do
        build(:task, priority: '', user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(no_priority_task.save).to be_falsy
      end
    end

    context 'when no deadline' do
      let!(:no_deadline_task) do
        build(:task, deadline: '', user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(no_deadline_task.save).to be_falsy
      end
    end

    context 'when no status' do
      let!(:no_status_task) do
        build(:task, status: '', user_id: user.id, team_id: team.id, topic_id: topic.id)
      end
      it 'should be false' do
        expect(no_status_task.save).to be_falsy
      end
    end

    context 'when no user_id' do
      let!(:no_user_id_task) { build(:task, team_id: team.id, topic_id: topic.id) }
      it 'should be false' do
        expect(no_user_id_task.save).to be_falsy
      end
    end

    context 'when no team_id' do
      let!(:no_team_id_task) { build(:task, user_id: user.id, topic_id: topic.id) }
      it 'should be false' do
        expect(no_team_id_task.save).to be_falsy
      end
    end

    context 'when no topic_id' do
      let!(:no_topic_id_task) { build(:task, user_id: user.id, team_id: team.id) }
      it 'should be false' do
        expect(no_topic_id_task.save).to be_falsy
      end
    end
  end
end
