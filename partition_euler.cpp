#include <iostream>
#include <chrono>
#include <fstream>
#include <cstdint>
#include <limits>

uintmax_t partition(int n) {
    if (n < 0) return 0;
    if (n == 0) return 1;

    uintmax_t result = 0;
    for (int k = 1; ; ++k) {
        int g_k1 = n - (k * (3 * k - 1)) / 2;
        int g_k2 = n - (k * (3 * k + 1)) / 2;

        if (g_k1 < 0 && g_k2 < 0) {
            break;
        }

        uintmax_t term1 = 0, term2 = 0;
        if (g_k1 >= 0) term1 = partition(g_k1);
        if (g_k2 >= 0) term2 = partition(g_k2);

        if (term1 == UINTMAX_MAX || term2 == UINTMAX_MAX) {
            return UINTMAX_MAX;
        }

        if (k % 2 == 1) {
            if (result > UINTMAX_MAX - term1) {
                return UINTMAX_MAX;
            }
            result += term1;

            if (result > UINTMAX_MAX - term2) {
                return UINTMAX_MAX;
            }
            result += term2;
        } else {
            if (result < term1) {
                return 0;
            }
            result -= term1;

            if (result < term2) {
                return 0;
            }
            result -= term2;
        }
    }

    return result;
}

int main() {
    std::ofstream outfile("euler_runtime_data.txt");

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

        if (n == 416) {
            break;
        }

        ++n;
    }

    outfile.close();

    return 0;
}
