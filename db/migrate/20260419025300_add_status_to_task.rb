# frozen_string_literal: true

class AddStatusToTask < ActiveRecord::Migration[8.1]
  def change
    def change
      add_column :tasks, :status, :string, default: "todo", null: false
    end
  end
end
