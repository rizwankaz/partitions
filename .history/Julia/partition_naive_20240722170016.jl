using BenchmarkTools

function partition(n::Int)
    dp = zeros(Int, n + 1)
    dp[1] = 1

    for i in 1:n
        for j in i:n
            dp[j + 1] += dp[j + 1 - i]
        end
    end

    return dp[n + 1]
end

function main()
    open("naive_runtime_data.txt", "w") do file
        write(file, "n\tpartition(n)\truntime (ns)\n")

        n = 1
        while true
            @btime result = partition(n)

            duration = minimum(@btime partition(n))

            write(file, "$(n)\t$(result)\t$(duration)\n")

            if n == 400
                break
            end

            n += 1
        end
    end
end

main()
