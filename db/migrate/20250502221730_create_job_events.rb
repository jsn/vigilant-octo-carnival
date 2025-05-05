class CreateJobEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :job_events do |t|
      t.references :job, null: false, foreign_key: true
      t.string :type, null: false

      t.timestamps
    end

    add_index :job_events, [:job_id, :created_at]
  end
end
