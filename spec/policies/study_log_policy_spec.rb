require 'rails_helper'

RSpec.describe StudyLogPolicy, type: :policy do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:other_user) { User.create!(email: 'other@example.com', password: 'password') }

  let(:record) do
    StudyLog.create!(
      title: 'test',
      content: 'content',
      category: '学習',
      user: user
    )
  end

  describe 'Scope' do
    it '自分の学習記録だけ取得できる' do
      other_record = StudyLog.create!(
        title: 'other',
        content: 'content',
        category: '学習',
        user: other_user
      )

      scope = Pundit.policy_scope!(user, StudyLog)

      expect(scope).to include(record)
      expect(scope).not_to include(other_record)
    end
  end

  describe '#show?' do
    it '本人なら許可される' do
      policy = StudyLogPolicy.new(user, record)
      expect(policy.show?).to be true
    end

    it '他人なら許可されない' do
      policy = StudyLogPolicy.new(other_user, record)
      expect(policy.show?).to be false
    end
  end

  describe '#update?' do
    it '本人なら許可される' do
      policy = StudyLogPolicy.new(user, record)
      expect(policy.update?).to be true
    end

    it '他人なら許可されない' do
      policy = StudyLogPolicy.new(other_user, record)
      expect(policy.update?).to be false
    end
  end

  describe '#destroy?' do
    it '本人なら許可される' do
      policy = StudyLogPolicy.new(user, record)
      expect(policy.destroy?).to be true
    end

    it '他人なら許可されない' do
      policy = StudyLogPolicy.new(other_user, record)
      expect(policy.destroy?).to be false
    end
  end
end
