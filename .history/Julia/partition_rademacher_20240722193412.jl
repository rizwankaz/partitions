using Printf

# Define the Dedekind sum
function dedekind_sum(h::BigInt, k::BigInt)::BigFloat
    s = zero(BigFloat)
    for n in 1:(k-1)
        s += (n/k) * (h*n/k - floor(h*n/k + 1//2))^2
    end
    return s
end

# Define the coefficient Ak
function A_k(n::BigInt, k::BigInt)::Complex{BigFloat}
    A_k_sum = zero(Complex{BigFloat})
    for h in 1:k
        if gcd(h, k) == 1
            exponent = -2 * pi * im * dedekind_sum(h, k)
            A_k_sum += exp(exponent)
        end
    end
    return A_k_sum
end

# Compute the partition function using Rademacher's formula
function partition(n::BigInt; tol::BigFloat=BigFloat(1e-10))::BigFloat
    pi = BigFloat(π)
    sqrt2 = sqrt(BigFloat(2))
    sqrt3 = sqrt(BigFloat(3))
    
    # Constant term outside the sum
    const_term = 1 / (pi * sqrt2)
    
    # Sum over k with convergence criterion
    p = zero(Complex{BigFloat})
    k = BigInt(1)
    while true
        Ak = A_k(n, k)
        term1 = sqrt(BigFloat(k))
        term2 = sinh(pi * sqrt(2/3 * (n - BigFloat(1)//BigFloat(24))) / k)
        term3 = sqrt(n - BigFloat(1)//BigFloat(24))
        term = Ak * term1 * term2 / term3
        
        if abs(term) < tol
            break
        end
        
        p += term
        k += 1
    end
    
    result = const_term * p
    return real(result)
end

# Example usage
n = BigInt(5)
result = partition(n)
@printf("The number of partitions of %d is approximately %.10f\n", n, result)
