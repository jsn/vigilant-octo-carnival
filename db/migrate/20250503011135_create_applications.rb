class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.references :job, null: false, foreign_key: true
      t.string :candidate_name, null: false
      t.string :status, null: false, default: 'applied'
      t.integer :notes_cnt, null: false, default: 0
      t.datetime :last_interview_at

      t.timestamps
    end
  end
end
