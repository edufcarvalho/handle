# frozen_string_literal: true

class CreateProviders < ActiveRecord::Migration[8.1]
  def change
    create_table :providers, id: :uuid do |t|
      t.string :name
      t.string :uid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
