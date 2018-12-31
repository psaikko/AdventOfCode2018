addr = ->(a,b,c) { "r[#{c}] = r[#{a}] + r[#{b}]" }
addi = ->(a,b,c) { "r[#{c}] = r[#{a}] + #{b}" }
mulr = ->(a,b,c) { "r[#{c}] = r[#{a}] * r[#{b}]" }
muli = ->(a,b,c) { "r[#{c}] = r[#{a}] * #{b}" }
banr = ->(a,b,c) { "r[#{c}] = r[#{a}] & r[#{b}]" }
bani = ->(a,b,c) { "r[#{c}] = r[#{a}] & #{b}" }
borr = ->(a,b,c) { "r[#{c}] = r[#{a}] | r[#{b}]" }
bori = ->(a,b,c) { "r[#{c}] = r[#{a}] | #{b}" }

setr = ->(a,b,c) { "r[#{c}] = r[#{a}]" }
seti = ->(a,b,c) { "r[#{c}] = #{a}" }

gtir = ->(a,b,c) { "r[#{c}] = (#{a} > r[#{b}])" }
gtri = ->(a,b,c) { "r[#{c}] = (r[#{a}] > #{b})" }
gtrr = ->(a,b,c) { "r[#{c}] = (r[#{a}] > r[#{b}])" }
eqir = ->(a,b,c) { "r[#{c}] = (#{a} == r[#{b}])" }
eqri = ->(a,b,c) { "r[#{c}] = (r[#{a}] == #{b})" }
eqrr = ->(a,b,c) { "r[#{c}] = (r[#{a}] == r[#{b}])" }

ops =  Hash[ [["addr",addr], ["addi",addi], ["mulr",mulr], ["muli",muli], 
        ["banr",banr], ["bani",bani], ["borr",borr], ["bori",bori], 
        ["setr",setr], ["seti",seti], ["gtir",gtir], ["gtri",gtri], 
        ["gtrr",gtrr], ["eqir",eqir], ["eqri",eqri], ["eqrr",eqrr]] ]

program = $<.each.map(&:strip)

print program[0]+"\n"
for instr in program.drop(1)
    opcode, a, b, c = instr.split
    puts ops[opcode].call(a, b, c)
end