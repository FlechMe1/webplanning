json.array! @events do |event|
  json.id event.id
  json.title event.label
  json.start event.begin_at
  json.end event.end_at
  json.url edit_event_path(event)
end
