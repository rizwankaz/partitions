#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <cinttypes>

uintmax_t partition(int n) {
    std::vector<uintmax_t> dp(n + 1, 0);
    dp[0] = 1;

    for (int i = 1; i <= n; ++i) {
        for (int j = i; j <= n; ++j) {
            if (dp[j] > UINTMAX_MAX - dp[j - i]) {
                return UINTMAX_MAX;
            }
            dp[j] += dp[j - i];
        }
    }

    return dp[n];
}

int main() {
    std::ofstream outfile("runtime_data.txt");

    outfile << "n\tpartition(n)\truntime\n";

    int n = 1;
    while (true) {
        auto start = std::chrono::high_resolution_clock::now();

        uintmax_t result = partition(n);

        if (result == UINTMAX_MAX) {
            break;
        }

        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        outfile << n << "\t" << result << "\t" << duration.count() << "\n";

        if (duration.count() >= 1.0) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}
