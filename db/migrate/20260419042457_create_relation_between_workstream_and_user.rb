# frozen_string_literal: true

class CreateRelationBetweenWorkstreamAndUser < ActiveRecord::Migration[8.1]
  def change
    add_column :workstreams, :user_id, :uuid, null: false
    add_foreign_key :workstreams, :users
  end
end
