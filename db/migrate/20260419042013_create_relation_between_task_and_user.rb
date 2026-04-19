# frozen_string_literal: true

class CreateRelationBetweenTaskAndUser < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :user_id, :uuid, null: false
    add_foreign_key :tasks, :users
  end
end
