require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:first_user) { FactoryBot.create(:user, admin: true) }

  describe '#validates' do

    context 'input name, email, password, password_confirmation' do
      let!(:normal_user) { FactoryBot.build(:user, name: 'Normal User', email: 'normal@mail.com') }
      it 'should be true' do
        expect(normal_user.save).to be true
      end
    end

    context 'when no name' do
      let!(:no_name_user) { FactoryBot.build(:user, name: '', email: 'noname@mail.com') }
      it 'should be false' do
        expect(no_name_user.save).to be false
      end
    end

    context 'when name length is over 50' do
      let!(:long_name) { "#{ 'a' * 51 }" }
      let!(:long_name_user) { FactoryBot.build(:user, name: long_name, email: 'longname@mail.com') }
      it 'should be false' do
        expect(long_name_user.save).to be false
      end
    end

    context 'when no email' do
      let!(:no_email_user) { FactoryBot.build(:user, email: '') }
      it 'should be false' do
        expect(no_email_user.save).to be false
      end
    end

    context 'email should be unique' do
      let!(:same_email_user) { FactoryBot.build(:user, name: 'Other User') }
      it 'should be false' do
        expect(same_email_user.save).to be false
      end
    end

    context 'when no password' do
      let!(:no_password_user) { FactoryBot.build(:user, email: 'nopass@mail.com', password: '') }
      it 'should be false' do
        expect(no_password_user.save).to be false
      end
    end
  end
end
