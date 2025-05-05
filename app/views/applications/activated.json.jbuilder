json.array! @applications do |app|
  json.(app, :candidate_name, :status, :notes_cnt, :last_interview_at)
  json.job_title app.job.title
end
