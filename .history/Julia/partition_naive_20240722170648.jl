using BenchmarkTools

function partition(n::BigInt)
    dp = Dict{BigInt, BigInt}()
    dp[BigInt(0)] = BigInt(1)

    for i in BigInt(1):n
        for j in i:n
            dp[j] = get(dp, j, BigInt(0)) + get(dp, j - i, BigInt(0))
        end
    end

    return get(dp, n, BigInt(0))
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