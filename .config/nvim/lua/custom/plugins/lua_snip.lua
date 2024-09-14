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
      s('leet', {
        t {
          '#include <bits/stdc++.h>',
          'using namespace std;',
          '',
          '#define forn(i, n) for (int i = 0; i < n; i++)',
          '#define forab(i, a, b) for (int i = a; i < b; i++)',
          '#define forba(i, a, b) for (int i = b; i > a; i--)',
          '',
          '#define pb push_back',
          '',
          '#define print(x) cout << x',
          '#define println(x) cout << x << endl',
          '#define printarr(x, n) cout << "{ "; forn(arrIndex, n) cout << x[arrIndex] << ", "; cout << "}" << endl;',
          '#define printmat(x, n, m) cout << "{" << endl; forn(arrHeightIndex, n) { cout << "\t{ "; forn(arrWidthIndex, m) cout << x[arrHeightIndex][arrWidthIndex] << ", "; cout << "}," << endl; }',
          '',
          '#define umap unordered_map',
          '#define prq priority_queue',
          '#define uset unordered_set',
          '',
          'using ll = long long;',
          'using vi = vector<int>;',
          'using vvi = vector<vi>;',
          '',
          'struct hash_pair {',
          '    template<class T1, class T2>',
          '    size_t operator()(const pair<T1, T2>& p) const {',
          '        auto hash1 = hash<T1>{}(p.first);',
          '        auto hash2 = hash<T2>{}(p.second);',
          '        return hash1 ^ hash2;',
          '    }',
          '};',
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
          '\t\t return 0;',
          '\t}',
          '};',
        },
      }),
    })

    -- Add more snippets for other languages or use cases here
  end,
}
