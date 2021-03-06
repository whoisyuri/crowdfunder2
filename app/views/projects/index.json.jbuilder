json.array!(@projects) do |project|
  json.extract! project, :id, :user_id, :title, :description, :goal, :startdate, :enddate
  json.url project_url(project, format: :json)
end
