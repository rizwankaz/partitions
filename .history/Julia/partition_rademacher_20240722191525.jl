using BenchmarkTools

function Ak(k::BigInt, n::BigInt)
    sum = BigFloat(0)
    for h in BigInt(1):k-1
        if gcd(h, k) == 1
            sum += cos((π * (2h - k) * (2n - 1)) / (2k))
        end
    end
    return sum
end

function partition(n::BigInt)
    if n <= 0
        return BigInt(n == 0 ? 1 : 0)
    end

    result = BigFloat(0)
    k = BigInt(1)
    while true
        term = Ak(k, n) * BigFloat(sqrt(k)) / n
        d_dn = 1 / sqrt(BigFloat(n) - BigFloat(1)/24)
        sinh_term = sinh(BigFloat(π) / k * BigFloat(sqrt(2/3 * (BigFloat(n) - BigFloat(1)/24))))
        
        increment = term * d_dn * sinh_term
        result += increment

        if abs(increment) < 1e-10
            break
        end
        k += 1
    end

    return round(BigInt, result / (2 * sqrt(3)))
end

function main()
    output_file = joinpath(@__DIR__, "rademacher_runtime_data.txt")
    open(output_file, "w") do file
        write(file, "n\tpartition(n)\truntime(s)\tmemory(bytes)\n")

        n = 1
        while true
            big_n = BigInt(n)
            
            result = BigInt(0)
            start_time = BigFloat(time())
            bytes = @allocated result = partition(big_n)
            end_time = BigFloat(time())
            
            runtime = end_time - start_time

            write(file, "$(n)\t$(result)\t$(runtime)\t$(bytes)\n")

            if runtime >= 1
                println("Runtime reached 1 second at n = $n")
                break
            end

            n += 1
        end
    end
end

main()