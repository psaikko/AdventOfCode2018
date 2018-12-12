file = File.new("input")

initial_state = file.gets.split()[2].strip
file.gets

transitions = file.each.map { |s| s.strip.split(" => ") }

tr =  Hash[ transitions ]

state = initial_state

offset = 0

for gen in 1..1000 do
    p state
    if state[0..3] != "...."
        state = "...." + state
        offset += 4
    end

    if state[-4..-1] != "...."
        state = state + "...." 
    end

    new_state = state.clone


    for i in 2..(state.length - 3) do
        new_state[i] = tr[ state[(i-2)..(i+2)] ]
    end

    state = new_state
end

n = state.chars.each_with_index.reject { |c,i| c == '.' }.map{|c,i| i-offset}.sum
c = state.chars.reject{|c| c == '.'}.length
p (n + c * (50000000000 - 1000))