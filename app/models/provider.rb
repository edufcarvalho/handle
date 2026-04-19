# frozen_string_literal: true

class Provider < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: { scope: :name }
end
