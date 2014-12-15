if url = ENV["PUSHER_URL"]
  Pusher.url = url
end
Pusher.encrypted = false
