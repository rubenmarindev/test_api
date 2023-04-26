require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without email' do
      subject.email = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without auth_token' do
      subject.auth_token = nil

      expect(subject).not_to be_valid
    end
  end
end
