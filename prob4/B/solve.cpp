#include <algorithm>
#include <iostream>
#include <vector>

int main(){
    int d, sum_time;
    std::cin >> d >> sum_time ;

    std::vector<std::pair<int, int>> limits;
    limits.reserve(d);
    auto sum_min_time = 0;
    auto sum_max_time = 0;
    for (auto i = 0; i < d; ++i) {
        int min_time, max_time;
        std::cin >> min_time >> max_time;
        sum_min_time += min_time;
        sum_max_time += max_time;
        limits.emplace_back(min_time, max_time - min_time);
    }

    if (sum_time < sum_min_time || sum_time > sum_max_time) {
        std::cout << "NO" << std::endl;
    } else {
        std::cout << "YES" << std::endl;
        sum_time -= sum_min_time;
        for (const auto& l: limits) {
            const auto extra = (sum_time >= l.second) ? l.second : sum_time;
            sum_time -= extra;
            std::cout << l.first + extra << " ";
        }
        std::cout << std::endl;
    }
}
