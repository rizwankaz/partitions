using BenchmarkTools

function partition(n::BigInt)
    memo = Dict{BigInt, BigInt}()
    memo[BigInt(0)] = BigInt(1)

    function p(m::BigInt)::BigInt
        if m < 0
            return BigInt(0)
        end
        if haskey(memo, m)
            return memo[m]
        end

        result = BigInt(0)
        k = BigInt(1)
        while true
            g_k1 = m - (k * (3k - 1)) ÷ 2
            g_k2 = m - (k * (3k + 1)) ÷ 2

            if g_k1 < 0 && g_k2 < 0
                break
            end

            term1 = p(g_k1)
            term2 = p(g_k2)

            if k % 2 == 1
                result += term1 + term2
            else
                result -= term1 + term2
            end
            k += 1
        end

        memo[m] = result
        return result
    end

    return p(n)
end

function main()
    open("euler_runtime_data.txt", "w") do file
        write(file, "n\tpartition(n)\truntime(n)\n")

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