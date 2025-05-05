class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, null: false, default: 'deactivated'
      t.integer :hired_cnt, :rejected_cnt, :ongoing_cnt, null: false, default: 0

      t.timestamps
    end
  end
end
