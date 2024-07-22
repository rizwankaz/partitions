using DataStructures

memo = Dict{Int, BigInt}()

function partition(n::BigInt)::BigInt
    if n < 0 
        return BigInt(0)
    end
    if n == 0 
        return BigInt(1)
    end
    
    if haskey(memo, n)
        return memo[n]
    end

    result = BigInt(0)
    k = 1
    while true
        g_k1 = n - (k * (3 * k - 1)) ÷ 2
        g_k2 = n - (k * (3 * k + 1)) ÷ 2

        if g_k1 < 0 && g_k2 < 0
            break
        end

        term1 = g_k1 >= 0 ? partition(g_k1) : BigInt(0)
        term2 = g_k2 >= 0 ? partition(g_k2) : BigInt(0)

        if k % 2 == 1
            result += term1
            result += term2
        else
            result -= term1
            result -= term2
        end
        k += 1
    end

    memo[n] = result
    return result
end

function main()
    open("euler_runtime_data.txt", "w") do file
        write(file, "n\tpartition(n)\truntime(s)\n")

        n = 1
        while true
            start_time = time()
            result = partition(n)
            end_time = time()
            
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