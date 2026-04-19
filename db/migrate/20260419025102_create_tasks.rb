# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :type
      t.string :description
      t.datetime :due_date
      t.string :priority
      t.string :title, null: false
      t.references :workstream, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
