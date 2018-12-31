#ip 1
require 'set'

halting_numbers = Set.new

a=b=c=d=e=ip= 0

ip=0; e = 123

loop do
    ip=1; e = e & 456
    ip=2; e = (e == 72) ? 1:0
    ip=3; ip = e + ip # JUMP e+1
    if e == 0
        ip=4; ip = 0      # GOTO 1
    else
        break
    end
end

ip=5; e = 0

loop do
    ip=6; d = e | 65536
    ip=7; e = 13431073

    loop do
        ip=8; c = d & 255
        ip=9; e = e + c
        ip=10; e = e & 16777215
        ip=11; e = e * 65899
        ip=12; e = e & 16777215
        ip=13; c = (256 > d) ? 1:0
        ip=14; ip = c + ip # JUMP c+1
        if c == 0
            ip=15; ip = ip + 1 # JUMP 2
        else
            ip=16; ip = 27     # GOTO 28
            break
        end
        ip=17; c = 0
        loop do
            ip=18; b = c + 1
            ip=19; b = b * 256
            ip=20; b = (b > d) ? 1:0
            ip=21; ip = b + ip  # JUMP b+1
            if b == 0
                ip=22; ip = ip + 1  # JUMP 2
                ip=24; c = c + 1
                ip=25; ip = 17      # GOTO 18
                next
            else
                ip=23; ip = 25      # GOTO 26
                break
            end
        end
        ip=26; d = c
        ip=27; ip = 7       # GOTO 8
    end

    ip=28; c = (e == a) ? 1:0
    if not halting_numbers.include? e
        halting_numbers.add e
        p e
    end
    ip=29; ip = c + ip  # JUMP c+1
    if c == 0
        ip=30; ip = 5
    else
        break
    end
end