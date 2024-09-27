return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    -- Load snippets from VSCode-like sources (friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Define custom snippets
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    -- Add snippets for HTML
    ls.add_snippets('html', {
      s('!', { -- Trigger `!`
        t {
          '<!DOCTYPE html>',
          '<html lang="en">',
          '<head>',
          '    <meta charset="UTF-8">',
          '    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
          '    <title>Document</title>',
          '</head>',
          '<body>',
          '\t<h1>',
        },
        i(1, 'Hello, world!'),
        t {
          '</h1>',
          '</body>',
          '</html>',
        },
      }),
    })

    ls.add_snippets('cpp', {
      -- Basic Snippet
      s('leet', {
        t {
          '#include <bits/stdc++.h>',
          'using namespace std;',
          '',
          'using ll = long long;',
          'using vi = vector<int>;',
          'using vvi = vector<vi>;',
          '',
          'class Solution {',
          'public:',
          '\t',
        },
        i(1, 'type function_name'),
        t '(',
        i(2, 'args'),
        t {
          ') {',
          '\t\t',
        },
        i(3, ''),
        t {
          '',
          '\t\treturn 0;',
          '\t}',
          '};',
        },
      }),

      -- Cycles Snippet
      s('cycles', {
        t {
          '#define forn(i, n) for (int i = 0; i < n; i++)',
          '#define forab(i, a, b) for (int i = a; i < b; i++)',
          '#define forba(i, a, b) for (int i = b; i > a; i--)',
        },
      }),

      -- Print Snippet
      s('prints', {
        t {
          '#define print(x) cout << x',
          '#define println(x) cout << x << endl',
          '#define printarr(x, n) cout << "{ "; forn(arrIndex, n) cout << x[arrIndex] << ", "; cout << "}" << endl;',
          '#define printmat(x, n, m) cout << "{" << endl; forn(arrHeightIndex, n) { cout << "\t{ "; forn(arrWidthIndex, m) cout << x[arrHeightIndex][arrWidthIndex] << ", "; cout << "}," << endl; }',
        },
      }),

      -- Containers Snippet
      s('containers', {
        t {
          '#define umap unordered_map',
          '#define prq priority_queue',
          '#define uset unordered_set',
        },
      }),

      -- Hash Pair Struct Snippet
      s('hashstruct', {
        t {
          'struct ',
        },
        i(1, 'hash_pair'),
        t {
          ' {',
          '    template<class T1, class T2>',
          '    size_t operator()(const pair<T1, T2>& p) const {',
          '        auto hash1 = hash<T1>{}(p.first);',
          '        auto hash2 = hash<T2>{}(p.second);',
          '        return hash1 ^ hash2;',
          '    }',
          '};',
        },
      }),

      -- ListNode Struct Snippet
      s('listnode', {
        t {
          'struct ListNode {',
          '    int val;',
          '    ListNode *next;',
          '    ListNode() : val(0), next(nullptr) {}',
          '    ListNode(int x) : val(x), next(nullptr) {}',
          '    ListNode(int x, ListNode *next) : val(x), next(next) {}',
          '};',
        },
      }),

      -- TreeNode Struct Snippet
      s('treenode', {
        t {
          'struct TreeNode {',
          '    int val;',
          '    TreeNode *left;',
          '    TreeNode *right;',
          '    TreeNode() : val(0), left(nullptr), right(nullptr) {}',
          '    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}',
          '    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}',
          '};',
        },
      }),

      s('codeforces', {
        t {
          '#include <bits/stdc++.h>',
          'using namespace std;',
          '',
          '#define forn(i, n) for (int i = 0; i < n; i++)',
          '#define forab(i, a, b) for (int i = a; i < b; i++)',
          '#define forba(i, a, b) for (int i = b; i > a; i--)',
          '',
          'using ll = long long;',
          'using vi = vector<int>;',
          'using vvi = vector<vi>;',
          '',
          '#define umap unordered_map',
          '#define prq priority_queue',
          '#define uset unordered_set',
          '',
          'void solve() {',
          '    ',
        },
        i(1),
        t {
          '',
          '}',
          '',
          'int main() {',
          '    ios::sync_with_stdio(0);',
          '    cin.tie(0);',
          '',
          '    int t;',
          '    cin >> t;',
          '    while (t--) {',
          '        solve();',
          '    }',
          '',
          '    return 0;',
          '}',
        },
      }),
    })

    -- Add more snippets for other languages or use cases here
  end,
}
