# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

fusion = Time.local(2015, 6, 25, 18, 0, 0)

SCHEDULER.every '1h', :first_in => 0 do |job|
  now = Time.now
  send_event('fusion-days_left', { value: (fusion - now).to_i / (24 *60 * 60) })
end
