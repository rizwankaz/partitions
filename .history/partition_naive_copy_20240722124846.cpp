#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <cstdint>
#include "BigInt.hpp"

BigInt partition(uintmax_t n) {
    std::vector<BigInt> dp(n + 1, BigInt(0));
    dp[0] = BigInt(1);

    for (uintmax_t i = 1; i <= n; ++i) {
        for (uintmax_t j = i; j <= n; ++j) {
            dp[j] = dp[j] + dp[j - i];
        }
    }

    return dp[n];
}

int main() {
    std::ofstream outfile("naive_runtime_data.txt");

    outfile << "n\tpartition(n)\truntime\n";

    int n = 1;
    while (true) {
        auto start = std::chrono::high_resolution_clock::now();

        BigInt result = partition(n);

        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        outfile << n << "\t" << result << "\t" << duration.count() << "\n";

        if (n == 400) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}
