require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'context' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'methods' do
    describe '#password=' do
      it 'assigns a password' do
        expect(BCrypt::Password).to receive(:create).with('abcdef')
        FactoryBot.build(:user, password: 'abcdef')
      end
    end

    describe '#ensure_session_token' do
      it 'ensures a session token exists' do
        expect(FactoryBot.build(:user).session_token).not_to be_nil
      end
    end

    describe '#reset_session_token' do
      it 'resets the session token' do
        expect(FactoryBot.build(:user).session_token).not_to be_nil
        # session_token != session[:session_token]
      end
    end

    # describe '::find_by_credentials' do
    #   it 'finds a user with the given credentials' do
        
    #   end
    # end

    # describe '#is_password?' do
    # end
  end
end