using BenchmarkTools

function partition(n::BigInt)
    dp = zeros(BigInt, n + 1)
    dp[BigInt(1)] = BigInt(1)

    for i in BigInt(1):n
        for j in i:n
            dp[j + BigInt(1)] += dp[j + BigInt(1) - i]
        end
    end

    return dp[n + BigInt(1)]
end

function main()
    open("naive_runtime_data.txt", "w") do file
        write(file, "n\tpartition(n)\truntime(n)\n")

        for n in 1:400
            big_n = BigInt(n)
            
            result, time = @btime partition($big_n)
            
            duration = time

            write(file, "$(n)\t$(result)\t$(duration)\n")
        end
    end
end

main()
