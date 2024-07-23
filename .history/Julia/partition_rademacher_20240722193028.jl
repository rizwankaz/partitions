using Printf
using BenchmarkTools

function dedekind(h::BigInt, k::BigInt)::BigFloat
    s = zero(BigFloat)
    for n in 1:(k-1)
        s += (n/k) * (h*n/k - floor(h*n/k + 1//2))^2
    end
    return s
end

function A_k(n::BigInt, k::BigInt)::BigFloat
    A_k_sum = zero(BigFloat)
    for h in 1:k
        if gcd(h, k) == 1
            exponent = -2 * pi * im * dedekind(h, k)
            A_k_sum += exp(exponent)
        end
    end
    return A_k_sum
end

function partition(n::BigInt)
    pi = BigFloat(π)
    sqrt2 = sqrt(BigFloat(2))
    sqrt3 = sqrt(BigFloat(3))
    
    const_term = 1 / (pi * sqrt2)
    
    p = zero(BigFloat)
    k = BigInt(1)
    while true
        Ak = A_k(n, k)
        term1 = sqrt(BigFloat(k))
        term2 = sinh(pi * sqrt(2/3 * (n - 1//24)) / k)
        term3 = sqrt(n - 1//24)
        term = Ak * term1 * term2 / term3
        
        if abs(term) < BigFloat(1e-10)
            break
        end
        
        p += term
        k += 1
    end
    
    return const_term * p
end

@printf(partition(5))