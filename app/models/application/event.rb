class Application::Event < ApplicationRecord
  belongs_to :application
  notifies_parent :application

  STATUS_EVENT_TYPES = [Hired, Rejected, Interview]

  scope :by_date, -> { order created_at: :desc }
  scope :notes, -> { where type: Note.name }
  scope :interviews, -> { where type: Interview.name }
  scope :status_changes, -> { where type: STATUS_EVENT_TYPES.map(&:name) }

  def to_status
    self.class.name.split('::').last.underscore
  end
end
