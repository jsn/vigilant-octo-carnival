class Application < ApplicationRecord
  belongs_to :job
  notifies_parent :job

  has_many :events

  after_association_changed :recalculate_aggregates

  protected

  def recalculate_aggregates
    self.status =
      self.events.by_date.status_changes.first&.to_status || 'applied'
    self.notes_cnt = self.events.notes.count
    self.last_interview_at = self.events.by_date.interviews.first&.created_at
    self.save!
  end
end
