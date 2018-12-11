n_players = 410
last_marble = 7205900

current_index = 0
current_player = 0

player_scores = Array.new(n_players, 0)

class Node
  attr_accessor :next, :prev, :value

  def initialize(val, pn = self, nn = self)
    @value = val
    @next  = nn
    @prev  = pn
    @next.prev = @prev.next = self
  end
  
  def insert_after(val)
    @next = Node.new(val,self,@next)
    return @next
  end

  def delete()
    @next.prev = @prev
    @prev.next = @next
  end

  def show()
    n = self
    c = @next

    print "#{@value} "
    while n != c do
      print "#{c.value} "
      c = c.next
    end
    print "\n"
  end

  def cw(n)
    t = self
    while n > 0 do
      t = t.next
      n -= 1
    end
    return t
  end

  def ccw(n)
    t = self
    while n > 0 do
      t = t.prev
      n -= 1
    end
    return t
  end
end

current_node = Node.new(0)

(1..last_marble).each do |i|
    #p a
    #p current_index
    #current_node.show
    if i % 23 != 0
      current_node = current_node.cw(1).insert_after(i)
    else 
      current_node = current_node.ccw(6)
      player_scores[current_player] += current_node.prev.value + i
      current_node.prev.delete
    end

    current_player = (current_player + 1) % n_players
end
#p a
p player_scores.max