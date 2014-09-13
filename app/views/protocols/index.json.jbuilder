json.array!(@protocols) do |protocol|
  json.extract! protocol, :id, :creator, :dateCreated, :dateSent, :text
  json.url protocol_url(protocol, format: :json)
end
