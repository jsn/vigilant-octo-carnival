class Application::Event::Hired < Application::Event
  validates :hired_at, presence: true
end
