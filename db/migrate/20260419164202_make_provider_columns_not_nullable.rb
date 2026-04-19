# frozen_string_literal: true

class MakeProviderColumnsNotNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :providers, :name, false
    change_column_null :providers, :uid, false
  end
end
