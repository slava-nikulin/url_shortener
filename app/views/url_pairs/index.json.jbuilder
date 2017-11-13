json.array!(@url_pairs) do |url_pair|
  json.original_url url_pair.original_url
  json.short_path url_pair.short_path
  json.clicks_count url_pair.clicks_count
  json.created_at url_pair.created_at.localtime.strftime("%d.%m.%Y %H:%M")
end
