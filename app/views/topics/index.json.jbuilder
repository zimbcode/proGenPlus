json.array!(@topics) do |topic|
  json.extract! topic, :id, :headline, :text, :protocol_id
  json.url topic_url(topic, format: :json)
end
