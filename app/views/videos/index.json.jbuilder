json.array!(@videos) do |video|
  json.extract! video, :id, :url
  json.url video_url(video, format: :json)
end
