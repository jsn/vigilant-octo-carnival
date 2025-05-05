class Application::Event::Note < Application::Event
  validates :content, presence: true
end
