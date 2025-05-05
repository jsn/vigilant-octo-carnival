# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

10.times do |j|
  job = Job.create! title: "Sample Job #{j}"

  rand(0 .. 4).times do |e|
    t = [Job::Event::Activated, Job::Event::Deactivated].sample
    job.events.create! type: t
  end

  rand(0 .. 4).times do |a|
    app = job.applications.create! candidate_name: "Candidate #{j} / #{a}"

    rand(0 .. 4).times do |e|
      t = [
        Application::Event::Interview, Application::Event::Note,
        Application::Event::Hired, Application::Event::Rejected,
      ].sample

      attrs = {type: t}
      case t.name.split("::").last
      when "Note"
        attrs[:content] = "note #{e}"
      when "Interview"
        attrs[:interview_at] = 1.day.from_now
      when "Hired"
        attrs[:hired_at] = 1.month.from_now
      end
      app.events.create! attrs
    end
  end
end
