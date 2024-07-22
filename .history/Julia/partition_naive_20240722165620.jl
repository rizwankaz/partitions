using Dates

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
            start_time = now()

            result = partition(n)

            end_time = now()
            duration = end_time - start_time
            duration_ns = Dates.value(duration)

            write(file, "$(n)\t$(result)\t$(duration_ns)\n")

            if n == 400
                break
            end

            n += 1
        end
    end
end

main()