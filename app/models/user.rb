class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy
  has_many :tasks
  has_many :children, class_name: "Workstream", foreign_key: :workstream_id
  belongs_to :parent, class_name: "Workstream", foreign_key: :workstream_id, optional: true, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, allow_nil: true, length: {minimum: 12}

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  enum :layout, {
    list: "list",
    board: "board",
    calendar: "calendar"
  }, default: "list", validate: true

  enum :color, {
    jet_black: "jet_black",
    strong_cyan: "strong_cyan",
    pearl_aqua: "pearl_aqua",
    mint_cream: "mint_cream",
    soft_blush: "soft_blush",
    powder_blush: "powder_blush",
    grapefruit_pink: "grapefruit_pink",
    grapefruit_pink_2: "grapefruit_pink_2",
    sandy_brown: "sandy_brown",
    royal_gold: "royal_gold"
  }, default: "jet_black", validate: true

  enum :visibility, {
    private: "private",
    public: "public",
    restricted: "restricted"
  }, default: "private", prefix: "", validate: true
end
