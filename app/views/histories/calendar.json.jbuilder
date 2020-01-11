json.array!(@histories) do |history|
  json.title history.name
  json.start history.start_date
  json.end history.end_date
  json.url history_url(history)
end