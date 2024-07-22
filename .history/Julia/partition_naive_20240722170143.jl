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

        for n in 1:400
            # Benchmark the partition function
            result, time = @btime partition($n)
            
            # Extract timing information from BenchmarkTools
            duration_ns = time * 1e9  # Convert seconds to nanoseconds

            # Write to the file
            write(file, "$(n)\t$(result)\t$(duration_ns)\n")
        end
    end
end

main()