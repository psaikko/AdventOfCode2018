n_players = gets.to_i
last_marble = gets.to_i

a = Array.new(1,0)
current_index = 0
current_player = 0

player_scores = Array.new(n_players, 0)

(1..last_marble).each do |i|
    #p a
    #p current_index
    p i
    if i % 23 != 0
      j = (current_index + 1) % (a.length) + 1
      a.insert(j, i)
      current_index = j
    else 
      j = (current_index - 7) % (a.length)
      player_scores[current_player] += a[j]
      a.delete_at(j)
      player_scores[current_player] += i

      current_index = j
    end

    current_player = (current_player + 1) % n_players
end
#p a
p player_scores.max