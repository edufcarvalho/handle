# frozen_string_literal: true

class AddColumnStatusToTask < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :status, :string, null: false, default: "todo"
  end
end
