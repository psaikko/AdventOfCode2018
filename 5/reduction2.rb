


input_chars = $<.read.chomp.chars

p ('A'..'Z').map { |c|

    stack = Array.new()

    tmp_chars = input_chars.reject { |x| x.upcase == c }

    tmp_chars.each do |ch|
        if stack.last && stack.last.upcase == ch.upcase && stack.last != ch
            stack.pop 
        else
            stack << ch
        end
    end

    [stack.length.to_s, c]
}.min