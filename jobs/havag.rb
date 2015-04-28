# encoding: utf-8

station = "Lutherstraße"
havag = Havag.new

SCHEDULER.every '20s', :first_in => 0 do |job|
    next_trains = havag.getNextTrains(station)
    next_trains.each do |train|
        delay = (train[:departure_real].to_time - train[:departure_scheduled].to_time).to_i
        if delay < 30
            train[:delay] = "in time"
        else
            train[:delay] = Time.at(delay).strftime("%M:%S min")
        end
        train[:departure_scheduled] = train[:departure_scheduled].strftime("%H:%M")
    end
    send_event('havag', {station: station, next_trains: next_trains[0..9]})
end

