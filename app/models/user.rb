# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :providers, dependent: :destroy

  has_many :children, class_name: "Workstream", foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: "Workstream", foreign_key: :parent_id, optional: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 8 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  def self.from_omniauth(auth)
    email = auth.info.email.presence&.downcase || "#{auth.uid}@#{auth.provider}.invalid"

    user = User.includes(:providers)
      .find_or_create_by(email:) do |u|
        u.name ||= auth.info.name
        u.password ||= SecureRandom.hex(16)
        u.verified = true
        u.avatar_url ||= auth.info.image
    end

    user.providers.find_or_create_by(name: auth.provider, uid: auth.uid)

    user
  end
end
