# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

cccamp = Time.local(2015, 8, 13, 18, 0, 0)

SCHEDULER.every '1h', :first_in => 0 do |job|
  now = Time.now
  send_event('cccamp-days_left', { value: (cccamp - now).to_i / (24 *60 * 60) })
end
