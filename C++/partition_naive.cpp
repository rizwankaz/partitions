#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <cstdint>

uintmax_t partition(uintmax_t n) {
    std::vector<uintmax_t> dp(n + 1, 0);
    dp[0] = 1;

    for (int i = 1; i <= n; ++i) {
        for (int j = i; j <= n; ++j) {
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

        uintmax_t result = partition(n);

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