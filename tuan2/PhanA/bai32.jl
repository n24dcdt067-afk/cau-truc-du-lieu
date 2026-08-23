function main()
    s = strip(read(stdin, String))
    isempty(s) && return
    n = parse(Int, s)
    n < 0 && (println("NO"); return)

    left, right, found = 0, min(n, 10^9), false
    while left <= right
        mid = left + div(right - left, 2)
        sq = mid * mid
        if sq == n
            found = true; break
        elseif sq < n
            left = mid + 1
        else
            right = mid - 1
        end
    end

    println(found ? "YES" : "NO")
end

main()