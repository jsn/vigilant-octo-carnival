class CreateApplicationEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :application_events do |t|
      t.references :application, null: false, foreign_key: true
      t.string :type, null: false, limit: 16
      t.datetime :interview_at
      t.datetime :hired_at
      t.text :content

      t.timestamps
    end
  end
end
