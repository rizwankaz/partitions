using BenchmarkTools

function partition(n::BigInt)
    dp = Dict{BigInt, BigInt}()
    dp[BigInt(0)] = BigInt(1)

    for i in BigInt(1):n
        for j in i:n
            dp[j] = get(dp, j, BigInt(0)) + get(dp, j - i, BigInt(0))
        end
    end

    return dp[n]
end

function main()
    output_file = joinpath(@__DIR__, "naive_runtime_data.txt")
    open(output_file, "w") do file
        write(file, "n\tpartition(n)\truntime(s)\n")

        n = 1
        while true
            big_n = BigInt(n)
            
            result = BigInt(0)
            start_time = BigFloat(time())
            result = partition(big_n)
            end_time = BigFloat(time())
            
            runtime = end_time - start_time

            write(file, "$(n)\t$(result)\t$(runtime)\n")

            if runtime >= 1
                println("Runtime reached 1 second at n = $n")
                break
            end

            n += 1
        end
    end
end

main()