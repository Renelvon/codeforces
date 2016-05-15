#include <cmath>
#include <cstdlib>
#include <iostream>
#include <memory>
#include <string>
#include <utility>

using divpair = std::pair<int, int>;
using solpair = std::pair<int, char>;

int div_by_num(int num, int divisor) {
    auto multiplicity = 0;
    do {
        const auto result = div(num, divisor);
        if (result.rem == 0) {
            num = result.quot;
            ++multiplicity;
        } else {
            break;
        }
    } while(num > 0);
    return multiplicity;
}

divpair num_to_div25(int num) {
    if (num == 0) {
        return std::make_pair(-1, -1);
    }

    auto multiplicity2 = 0;
    auto multiplicity5 = 0;
    do {
        const auto result = div(num, 10);
        if (result.rem == 0) {
            num = result.quot;
            ++multiplicity2;
            ++multiplicity5;
        } else {
            break;
        }
    } while(num > 0);

    do {
        const auto result = div(num, 5);
        if (result.rem == 0) {
            num = result.quot;
            ++multiplicity5;
        } else {
            break;
        }
    } while(num > 0);


    do {
        const auto result = div(num, 2);
        if (result.rem == 0) {
            num = result.quot;
            ++multiplicity2;
        } else {
            break;
        }
    } while(num > 0);

    return std::make_pair(multiplicity2, multiplicity5);
}

int add(const int num1, const int num2) {
    if (num1 == -1 || num2 == -1) {
        return -1;
    }
    return num1 + num2;
}

bool less(const int num1, const int num2) {
    if (num1 == -1) {
        return num2 != 0;
    } else if (num2 == -1) {
        return num1 == 0;
    } else {
        return num1 < num2;
    }
}

std::pair<int, std::string>
solve(const int divmult[], solpair sol[], const int N) {
    auto div2D = std::unique_ptr<const int*[]>(new const int*[N]);
    for (auto i = 0; i < N; ++i) {
        div2D[i] = &divmult[i * N];
    }
    
    auto sol2D = std::unique_ptr<solpair*[]>(new solpair*[N]);
    for (auto i = 0; i < N; ++i) {
        sol2D[i] = &sol[i * N];
    }

    sol2D[N -1][N - 1].first = div2D[N - 1][N - 1];
    sol2D[N -1][N - 1].second = 'E';
    for (auto j = N - 1; j-- > 0;) {
        const auto next = sol2D[N - 1][j + 1];
        sol2D[N - 1][j].first = add(next.first, div2D[N - 1][j]);
        sol2D[N - 1][j].second = 'R';
    } 

    for (auto i = N - 1; i-- > 0;) {
        const auto next = sol2D[i + 1][N - 1];
        sol2D[i][N - 1].first = add(next.first, div2D[i][N - 1]);
        sol2D[i][N - 1].second = 'D';
    } 

    for (auto i = N - 1; i-- > 0;) {
        for (auto j = N - 1; j-- > 0;) {
            const auto& right = sol2D[i][j + 1];
            const auto& down = sol2D[i + 1][j];

            if (less(right.first, down.first)) {
                sol2D[i][j].first = add(right.first, div2D[i][j]);
                sol2D[i][j].second = 'R';
            } else {
                sol2D[i][j].first = add(down.first, div2D[i][j]);
                sol2D[i][j].second = 'D';
            }
        }
    }
    
    const auto solution = sol2D[0][0];
    const auto best = solution.first;

    std::string path;
    auto cur_step = solution.second;
    for (auto i = 0, j = 0; cur_step != 'E'; cur_step = sol2D[i][j].second) {
        path.append(1, cur_step);
        if (cur_step == 'D') {
            ++i;
        } else if (cur_step == 'R') {
            ++j;
        }
    }
            
    return std::make_pair(best, path);
}

int main(){
    int N;
    std::cin >> N;

    auto mem2 = std::unique_ptr<int[]>(new int[2 * N * N]);
    auto mem5 = &mem2[N * N];
    for (auto i = 0; i < N * N; ++i) {
        int num;
        std::cin >> num;
        const auto divisors = num_to_div25(num);
        mem2[i] = divisors.first;
        mem5[i] = divisors.second;
    }

    auto memsol = std::unique_ptr<solpair[]>(new solpair[N * N]);
    const auto solution2 = solve(mem2.get(), memsol.get(), N);
    const auto solution5 = solve(mem5, memsol.get(), N);
    const auto solution = less(solution2.first, solution5.first) ? solution2 : solution5;
    std::cout << abs(solution.first) << std::endl
              << solution.second << std::endl;
}
