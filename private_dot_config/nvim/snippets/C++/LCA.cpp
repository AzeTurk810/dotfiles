#include <vector>
template <typename T>
struct GraphLCA {
    int K = 20, n;
    std::vector<int> inT, outT, lvl;
    std::vector<std::vector<int>> up, *adj;
    LCA(int _n) : n(_n) {
        up.resize(K, std::vector<int>(_n + 1));
    }

    void buildLCA(void) {
        for (int v = 1; v <= n; v++) {
            up[0][v] = parent[v];
        }
        for (int i = 1; i < K; i++) {
            for (int v = 1; v <= n; v++) {
                up[i][v] = up[i - 1][up[i - 1][v]];
            }
        }
    }

    char isAnsestor(int u, int v) {
        return (inT[u] <= inT[v] && outT[v] <= outT[u]);
    }

    int lca(int u, int v) {
        if (lvl[u] > lvl[v]) {
            swap(u, v);
        }
        if (isAnsestor(u, v)) {
            return u;
        }
        if (isAnsestor(v, u)) {
            return v;
        }
        int dif = lvl[v] - lvl[u];
        for (int i = K - 1; i >= 0; --i) {
            if ((1 << i) & dif) {
                v = up[i][v];
            }
        }
        for (int i = K - 1; i >= 0; --i) {
            if (up[i][v] != up[i][u]) {
                 v = up[i][v];
                 u = up[i][u];
            }
        }
        return up[0][v];
    }
};
