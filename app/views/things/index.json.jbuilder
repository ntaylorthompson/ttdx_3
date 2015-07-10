json.array!(@things) do |thing|
  json.extract! thing, :id, :user_id, :object_description, :problem_description, :solution_description
  json.url thing_url(thing, format: :json)
end
