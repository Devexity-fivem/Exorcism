local gigasecond = {}

function gigasecond.anniversary(any_date)
  local gigasecond_in_seconds = 1e9
  return os.date('%x', any_date + gigasecond_in_seconds)
end

return gigasecond
