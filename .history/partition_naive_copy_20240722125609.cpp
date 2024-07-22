#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <cstdint>
#include <gmp.h>

void partition(uintmax_t n, mpz_t result) {
    std::vector<mpz_t> dp(n + 1);
    for (uintmax_t i = 0; i <= n; ++i) {
        mpz_init(dp[i]);
    }
    mpz_set_ui(dp[0], 1);

    for (uintmax_t i = 1; i <= n; ++i) {
        for (uintmax_t j = i; j <= n; ++j) {
            mpz_add(dp[j], dp[j], dp[j - i]);
        }
    }

    mpz_set(result, dp[n]);

    for (uintmax_t i = 0; i <= n; ++i) {
        mpz_clear(dp[i]);
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
        partition(n, result);

        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        outfile << n << "\t" << mpz_get_str(nullptr, 10, result) << "\t" << duration.count() << "\n";

        mpz_clear(result);

        if (n == 400) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}
