class Job < ApplicationRecord
  has_many :events
  has_many :applications

  scope :activated, -> { where status: 'activated' }

  after_association_changed :recalculate_aggregates

  protected

  def recalculate_aggregates
    self.status = self.events.by_date.first&.to_status || 'deactivated'
    cnts = self.applications.group(:status).count
    self.hired_cnt = cnts['hired'] || 0
    self.rejected_cnt = cnts['rejected'] || 0
    self.ongoing_cnt = cnts.values.inject(0, &:+) - hired_cnt - rejected_cnt
    self.save!
  end
end
