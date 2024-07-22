#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <gmpxx.h>

mpz_class partition(unsigned int n) {
    std::vector<mpz_class> dp(n + 1);

    dp[0] = 1;

    for (unsigned int i = 1; i <= n; ++i) {
        for (unsigned int j = i; j <= n; ++j) {
            dp[j] += dp[j - i];
        }
    }

    return dp[n];
}

int main() {
    std::ofstream outfile("naive_runtime_data.txt");

    if (!outfile) {
        std::cerr << "Error creating file!" << std::endl;
        return 1;
    }

    outfile << "n\tpartition(n)\truntime\n";
    std::cout << "File created successfully!" << std::endl;

    int n = 1;
    while (true) {
        auto start = std::chrono::high_resolution_clock::now();

        mpz_class result = partition(n);

        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        outfile << n << "\t" << result << "\t" << duration.count() << "\n";
        std::cout << "n: " << n << " result: " << result << " runtime: " << duration.count() << "s" << std::endl;

        if (n == 400) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}