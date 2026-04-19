# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :workstream, optional: true
  belongs_to :user

  validates :title, presence: true

  enum :priority, {
    low: "low",
    medium: "medium",
    high: "high"
  }, default: "medium", validates: true

  enum :status, {
    todo: "todo",
    in_progress: "in_progress",
    done: "done"
  }, default: "todo", validates: true
end
