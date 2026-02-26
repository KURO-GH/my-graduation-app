# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :study_logs, dependent: :destroy
  has_many :habits, dependent: :destroy   # ← これ追加

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    existing_user = find_by(email: auth.info.email)
    if existing_user
      existing_user.update(
        provider: auth.provider,
        uid: auth.uid
      )
      return existing_user
    end

    create(
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      provider: auth.provider,
      uid: auth.uid
    )
  end
end
