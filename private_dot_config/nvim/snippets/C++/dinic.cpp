template <typename T>
struct Dinic {
    T INF;
    struct Edge {
        int u, v;
        T flow, capacity;
        Edge(int v, int u, T capacity) : capacity(capacity), u(u), v(v) {
            ;
        }
    };
    vector<int> level, ptr;
    queue<int> q;
    vector<Edge> edges;
    vector<vector<int>> adj;
    int s, t;
    int n, m = 0;
    void systemd(void) {
        adj.assign(n + 1, {});
        level.resize(n + 1);
        ptr.resize(n + 1);
        m = 0;
    }

    Dinic(int n, int s, int t, T INF) : n(n), s(s), t(t), INF(INF) {
        systemd();
    }

    void addEdge(int v, int u, long long capacity) {
        edges.emplace_back(v, u, capacity);
        edges.emplace_back(u, v, 0);
        adj[v].push_back(m);
        adj[u].push_back(m + 1);
        m += 2;
    }

    bool bfs(void) {
        fill(level.begin(), level.end(), -1);
        level[s] = 0;
        q.push(0);
        while (!q.empty()) {
            int v = q.front();
            q.pop();
            for (const int &id : adj[v]) {
                if (edges[id].capacity == edges[id].flow) {
                    continue;
                }
                if (level[edges[id].u] != -1) {
                    continue;
                }
                level[edges[id].u] = level[v] + 1;
                q.push(edges[id].u);
            }
        }
        return level[t] != -1;
    }

    T dfs(int v, T flow) {
        if (flow == 0) {
            return 0;
        }
        if (v == t) {
            return flow;
        }
        for (int &cid = ptr[v]; cid < (int)adj[v].size(); cid++) {
            const int &id = adj[v][cid];
            const int &u = edges[id].u;
            if (level[v] + 1 != level[u]) {
                continue;
            }
            T newFlow = dfs(u, min(flow, edges[id].capacity - edges[id].flow));
            if (newFlow == 0) {
                continue;
            }
            edges[id].flow += newFlow;
            edges[id ^ 1].flow -= newFlow;
            return newFlow;
        }
        return 0;
    }

    T maxFlow() {
        T flow = 0;
        T newFlow;
        while (!bfs()) {
            fill(ptr.begin(), ptr.end(), 0);
            while (newFlow = dfs(s, INF)) {
                flow += newFlow;
            }
        }
        return flow;
    }
};
