template<typename T>
struct segTree {
#define lv (v << 1)
#define rv ((v << 1) | 1)
    int n_;
    std::vector<T> t;
    T NullRes; /// WARNING: IMPORTANT
    std::function<T(T, T)> marge_ = [&](const T &l, const T &r) {
        return min(l, r);
    };
    std::function<T(T, T)> marge;

    void pull(int v) {
        t[v] = marge(t[lv], t[rv]);
    }

    void build(const std::vector<T> &A, const int n) {
        n_ = 1;
        while (n_ < (n << 1)) {
            n_ <<= 1;
        }
        t.assign((n_ << 1), NullRes);
        for (int i = 0; i < n; i++) {
            t[n_ + i] = A[i];
        }

        for (int i = n_ - 1; i >= 1; --i) {
            pull(i);
        }
    }

    void update(int i, const T x) {
        i += n_;
        t[i] = x;
        while (i > 1) {
            pull(i >>= 1);
        }
    }

    T query(int ql, int qr) {
        int l = ql + n_;
        int r = qr + n_;
        T res = NullRes;
        while (l <= r) {
            if (l & 1) {
                res = marge(t[l], res);
                l++;
            }
            if (!(r & 1)) {
                res = marge(res, t[r]);
                r--;
            }
            l >>= 1;
            r >>= 1;
        }
        return res;
    }
#undef lv
#undef rv
};
