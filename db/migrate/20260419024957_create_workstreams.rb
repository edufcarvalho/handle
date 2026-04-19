# frozen_string_literal: true

class CreateWorkstreams < ActiveRecord::Migration[8.1]
  def change
    create_table :workstreams, id: :uuid do |t|
      t.string :name, null: false
      t.string :color, null: false, default: "jet_black"
      t.string :layout, null: false, default: "list"
      t.string :access, null: false, default: "private"
      t.references :parent, foreign_key: { to_table: :workstreams }, type: :uuid

      t.timestamps
    end
  end
end
