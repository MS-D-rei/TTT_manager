require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let!(:user) { create(:user) }
  let!(:team) { create(:team, leader_id: user.id) }
  let!(:topic) { create(:topic, user_id: user.id, team_id: team.id) }
  let!(:task) { create(:task, user_id: user.id, team_id: team.id, topic_id: topic.id) }

  describe '#validates' do
    context 'when has user_id, task_id both' do
      let!(:proper_bookmark) { build(:bookmark, user_id: user.id, task_id: task.id) }
      it 'should be true' do
        expect(proper_bookmark.save).to be_truthy
      end
    end

    context 'when no user_id' do
      let!(:no_user_id_bookmark) { build(:bookmark, task_id: task.id) }
      it 'should be false' do
        expect(no_user_id_bookmark.save).to be_falsy
      end
    end

    context 'when no task_id' do
      let!(:no_task_id_bookmark) { build(:bookmark, user_id: user.id) }
      it 'should be false' do
        expect(no_task_id_bookmark.save).to be_falsy
      end
    end

    context 'when already has the same user_id, task_id combination' do
      let!(:first_bookmark) { create(:bookmark, user_id: user.id, task_id: task.id) }
      let!(:duplicated_bookmark) { build(:bookmark, user_id: user.id, task_id: task.id) }
      it 'the combination should be unique, so it should be false' do
        expect(duplicated_bookmark.save).to be_falsy
      end
    end
  end
end
