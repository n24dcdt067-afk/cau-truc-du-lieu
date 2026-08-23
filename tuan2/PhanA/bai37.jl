# Julia (bai37.jl)
function main()
    tokens = split(read(stdin, String))
    if isempty(tokens) return end

    n = parse(Int, tokens[1])
    so_chan = 0
    so_le = 0
    so_am = 0

    for i in 2:(n + 1)
        x = parse(Int, tokens[i])
        if x % 2 == 0
            so_chan += 1
        else
            so_le += 1
        end

        if x < 0
            so_am += 1
        end
    end

    println("chan $so_chan, le $so_le, am $so_am")
end

main()