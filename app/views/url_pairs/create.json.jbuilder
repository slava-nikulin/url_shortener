json.success @url_pair.valid?
json.errors @url_pair.errors.messages

json.url_pair do
  json.original_url @url_pair.original_url
  json.short_path @url_pair.short_path
end
