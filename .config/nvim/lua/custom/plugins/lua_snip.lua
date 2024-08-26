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
        i(3, 'body'),
        t {
          '',
          '\t}',
          '};',
        },
      }),
    })

    -- Add more snippets for other languages or use cases here
  end,
}
