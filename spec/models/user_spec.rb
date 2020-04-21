require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email}
    it { should validate_presence_of :password}
    it { should have_secure_password }
    it { should validate_presence_of :password_digest}
    it { should have_secure_token :api_key}
  end

  describe 'user creation' do
    it 'is created with valid parameters' do
      user = User.new(email: 'hello@works.com', password: 'password', password_confirmation: 'password')

      expect(user.save).to eq(true)
    end

    it 'is not created with invalid parameters' do
      user = User.new(email: 'hello@works.com', password: '', password_confirmation: 'password')

      expect(user.save).to eq(false)
    end
  end
end
