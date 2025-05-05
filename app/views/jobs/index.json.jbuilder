json.array! @jobs do |job|
  json.(job, :title, :status, :hired_cnt, :rejected_cnt, :ongoing_cnt)
end
