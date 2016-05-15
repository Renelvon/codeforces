#include <algorithm>
#include <iostream>
#include <iterator>
#include <vector>

int main(){
    int N, V;
    std::cin >> N >> V;

    std::vector<std::pair<int, int>> kayaks;
    kayaks.emplace_back(0, -1);
    kayaks.emplace_back(0, -2);

    std::vector<std::pair<int, int>> catamarans;
    catamarans.emplace_back(0, -1);

    for (auto i = 1; i <= N; ++i) {
        int type, capacity;
        std::cin >> type >> capacity;
        if (type == 1) {
            kayaks.emplace_back(capacity, i);
        } else {
            catamarans.emplace_back(capacity, i);
        }
    }

    std::sort(kayaks.begin(), kayaks.end());
    std::sort(catamarans.begin(), catamarans.end());

    auto k = kayaks.size() - 1;
    auto c = catamarans.size() - 1;
    auto capacity = 0;
    std::vector<int> answer;

    while (V > 1 && (k > 1 || c > 0)) {
        const auto& cat = catamarans[c];
        const auto& kay1 = kayaks[k];
        const auto& kay2 = kayaks[k - 1];
        if (cat.first >= kay1.first + kay2.first) {
            capacity += cat.first;
            answer.push_back(cat.second);
            --c;
            V -= 2;
        } else {
            capacity += kay1.first;
            answer.push_back(kay1.second);
            --k;
            --V;
        }
    }

    if (V > 0 && k > 1) {
        const auto& kay = kayaks[k];
        capacity += kay.first;
        answer.push_back(kay.second);
    }

    std::cout << capacity << std::endl;
    std::ostream_iterator<int> out(std::cout, " ");
    std::copy(answer.cbegin(), answer.cend(), out);
    std::cout << std::endl;
}
