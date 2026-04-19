# frozen_string_literal: true

class Workstream < ApplicationRecord
  has_many :tasks
  has_many :children, class_name: "Workstream", foreign_key: :workstream_id
  belongs_to :parent, class_name: "Workstream", foreign_key: :workstream_id, optional: true, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :name, presence: true

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
