json.array!(@solutions) do |solution|
  json.extract! solution, :id, :kind, :description, :issues_description, :user_id, :thing_id
  json.url solution_url(solution, format: :json)
end
