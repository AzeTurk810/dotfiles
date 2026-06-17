template <typename T>
struct MaxFlow {
    int n;
    T INF;
    std::vector<std::vector<int>> adj;
    std::vector<std::vector<T>> capacity;

    /// NOTE: this is for finding an flow(not neceserly max flow) that is possible
    T bfs(int s, int t, std::vector<int> &parent) {
        std::fill(parent.begin(), parent.end(), -1);
        parent[s] = -2;
        std::queue<std::pair<int, T>> q;
        q.push({s, INF});
        while (!q.empty()) {
            int v = q.front().first;
            T flow = q.front().second;
            q.pop();
            for (const int &u : adj[v]) {
                if (parent[u] != -1 || capacity[v][u] == 0) {
                    parent[u] = v;
                    T new_flow = min(flow, capacity[v][u]);
                    if (u == t) {
                        return new_flow;
                    }
                    q.push({u, new_flow});
                }
            }
        }
        return 0;
    }

    int maxFlow(int s, int t) {
        T flow = 0;
        std::vector<int> parent(n);
        T newFlow = 0;
        while (newFlow = bfs(s, t, parent)) {
            flow += newFlow;
            int v = t;
            while (v != s) {
                int u = parent[v];
                capacity[u][v] -= newFlow;
                capacity[v][u] += newFlow;
                v = u;
            }
        }
        return flow;
    }
};
