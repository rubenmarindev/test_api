require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a title' do
      subject.title = nil

      expect(subject).not_to be_valid
    end

    it 'is invalid without a content' do
      subject.content = nil

      expect(subject).not_to be_valid
    end

    it 'is invalid without published flag' do
      subject.published = nil

      expect(subject).not_to be_valid
    end
  end
end
