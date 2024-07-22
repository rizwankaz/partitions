#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <gmp.h>

void partition(mpz_t result, unsigned int n) {
    std::vector<mpz_t> dp(n + 1);

    for (auto &val : dp) {
        mpz_init(val);
    }
    mpz_set_ui(dp[0], 1);

    for (unsigned int i = 1; i <= n; ++i) {
        for (unsigned int j = i; j <= n; ++j) {
            mpz_add(dp[j], dp[j], dp[j - i]);
        }
    }

    mpz_set(result, dp[n]);

    for (auto &val : dp) {
        mpz_clear(val);
    }
}

int main() {
    std::ofstream outfile("naive_runtime_data.txt");

    outfile << "n\tpartition(n)\truntime\n";

    int n = 1;
    while (true) {
        auto start = std::chrono::high_resolution_clock::now();

        mpz_t result;
        mpz_init(result);

        partition(result, n);

        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        outfile << n << "\t";
        mpz_out_str(outfile.rdbuf(), 10, result);
        outfile << "\t" << duration.count() << "\n";

        mpz_clear(result);

        if (n == 400) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}
