json.array! @events do |event|
  json.id event.id
  json.title event.label
  json.start event.begin_at.to_date
  json.end event.end_at.tomorrow.to_date unless event.end_at.blank?
  json.url edit_event_path(event)
end
