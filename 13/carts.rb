require 'set'

lines = $<.each.map{|l| l[0..-2]}.map(&:chars)

def parse_carts(lines)
    arr = []
    lines.each_with_index { |row, i|
        row.each_with_index { |char, j| 
            if "<^v>".include? char
                arr << [char, j, i]
            end
        }
    }
    arr
end

cart_locations = parse_carts(lines)

p cart_locations

# remove carts from lines
lines = lines.each.map { |row| row.map { |char|
        case char
        when /[\^v]/
            '|'
        when /[<>]/
            '-'
        else
            char
        end
    } 
}

# add turning memory
cart_data = cart_locations.map { |l| l << 0 }

def intersect(cart, dir) 
    dir = dir % 3
    sym = "<^>v"
    i = sym.index cart
    if dir == 0
        return sym[ (i - 1) % 4 ]
    elsif dir == 1
        return cart
    else
        return sym[ (i + 1) % 4 ]
    end
end

def turn(cart, turn)
    if turn == "/"
        case cart
        when '^'
            return ">"
        when 'v'
            return "<"
        when '<'
            return "v"
        when '>'
            return "^"
        end   
    elsif turn == "\\"
        case cart
        when '^'
            return "<"
        when 'v'
            return ">"
        when '<'
            return "^"
        when '>'
            return "v"
        end   
    else
        raise [cart, turn]
    end
end

#p lines
#print lines.map(&:join).join("\n")+"\n"

#p cart_data

for i in (1..100000) do
    cart_data.sort_by! { |x| x[1..2].reverse }.reverse!
    
    # p cart_data

    # for (line, y) in lines.each_with_index do
    #     for (char, x) in line.each_with_index do
    #         if cart_data.map{|a| a[1..2]}.include? [x,y] 
    #             print "X"
    #         else
    #             print char
    #         end
    #     end
    #     print "\n"
    # end

    new_cart_data = []

    while cart_data.length > 0 do
        data = cart_data.pop
        symbol, x, y, mem = data
        case symbol
        when "<"
            x -= 1
        when ">"
            x += 1
        when "^"
            y -= 1
        when "v"
            y += 1
        end

        case lines[y][x]
        when /[\|\-]/
            # no turn
        when /[\/\\]/
            symbol = turn(symbol, lines[y][x])
        when '+'
            symbol = intersect(symbol, mem)
            mem += 1
        end

        data[0] = symbol
        data[1] = x
        data[2] = y
        data[3] = mem

        new_cart_data << data

        crash = false

        s = Set.new()
        (cart_data + new_cart_data).map{|a| a[1..2]}.each do |c|
            if s.include? c
                p c
                crash = true
                s.delete c
            else
                s.add c
            end
        end

        cart_data.reject! { |a| 
            not s.include? a[1..2]
        }

        new_cart_data.reject! { |a| 
            not s.include? a[1..2]
        }
    end

    cart_data = new_cart_data

    if cart_data.length < 2
        p cart_data
        break
    end
end