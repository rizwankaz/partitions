#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include "BigInt.hpp"

BigInt partition(BigInt n) {
    std::vector<BigInt> dp(n + 1, 0);
    dp[0] = 1;

    for (BigInt i = 1; i <= n; ++i) {
        for (BigInt j = i; j <= n; ++j) {
            dp[j] += dp[j - i];
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

        if (n ==400) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}