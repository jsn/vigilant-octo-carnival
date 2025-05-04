class Job::Event < ApplicationRecord
  belongs_to :job
  notifies_parent :job

  scope :by_date, -> { order created_at: :desc }

  def to_status
    self.class.name.split('::').last.underscore
  end
end
