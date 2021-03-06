require 'date'

lines = File.new("input").readlines()

events = []

lines.each do |line|
    time = DateTime.strptime(line[0..18], "[%Y-%m-%d %H:%M]").to_time
    action = line[19..-1].split()[1]
    events << [time, action]
end

events.sort!

current_guard = 0
asleep_at = 0

sleep_minutes = Hash.new(0)

guard_minutes = Hash.new { |h,k| h[k] = Array.new(60,0) }


events.each do |time, action|
    
    day = time.mday
    now = time.min

    if action == "up"
        sleep_minutes[current_guard] += now - asleep_at
        (asleep_at...now).each do |i|
            guard_minutes[current_guard][i] += 1
        end
    elsif action == "asleep"
        asleep_at = now
    else
        current_guard = action[1..-1].to_i
    end
end

g, ms = guard_minutes.max_by { |guard, minutes|
    minutes.max
}

m, i = ms.each_with_index.max_by { |m,i| m }

p g
p m
p i
p g*i