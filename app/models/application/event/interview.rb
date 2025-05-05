class Application::Event::Interview < Application::Event
  validates :interview_at, presence: true
end
