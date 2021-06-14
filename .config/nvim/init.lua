-- ALIASES -------------------------------------------------------
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

-- PLUGINS -------------------------------------------------------
-- auto install paq-nvim
local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/savq/paq-nvim.git '..install_path)
end

cmd 'packadd paq-nvim'             -- Load package
local paq = require'paq-nvim'.paq

-- update treesitter parsers
local function update_ts_parsers() cmd 'TSUpdate' end

paq {'savq/paq-nvim', opt=true}    -- Let Paq manage itself
paq 'b3nj5m1n/kommentary'
paq 'dense-analysis/ale'
paq 'doums/coBra'
paq 'doums/oterm'
paq 'doums/fzfTools'
paq 'doums/espresso'
paq 'doums/sae'
paq 'doums/lsp_status'
paq 'doums/lens'
paq {'nvim-treesitter/nvim-treesitter', run=update_ts_parsers}
paq 'neovim/nvim-lspconfig'
paq 'hrsh7th/nvim-compe'
paq 'norcalli/snippets.nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-lua/plenary.nvim'        -- dep of telescope.nvim, gitsigns.nvim
paq 'nvim-lua/popup.nvim'          -- dep of telescope.nvim
paq 'nvim-telescope/telescope.nvim'
paq 'lewis6991/gitsigns.nvim'
paq 'pantharshit00/vim-prisma'
paq 'tweekmonster/startuptime.vim'
paq 'kyazdani42/nvim-tree.lua'
paq 'kyazdani42/nvim-web-devicons' -- dep of nvim-tree.lua
paq 'ggandor/lightspeed.nvim'

-- HELPERS -------------------------------------------------------
-- `t` for `termcodes`.
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- map with `noremap` option set to `true` by default
local function map(mode, lhs, rhs, opts)
  opts = opts or {noremap = true}
  if opts.noremap == nil then opts.noremap = true end
  if opts.buffer then
    opts.buffer = nil
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
  else
    opts.buffer = nil
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

-- log util
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

local function hi(name, foreground, background, style)
  local fg = 'guifg='..(foreground or 'NONE')
  local bg = 'guibg='..(background or 'NONE')
  local decoration = 'gui='..(style or 'NONE')
  local hi_command = string.format('hi %s %s %s %s', name, fg, bg, decoration)
  cmd(hi_command)
end

local function li(target, source)
  cmd(string.format('hi! link %s %s', target, source))
end

-- OPTIONS -------------------------------------------------------
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.shortmess = 'IFaWcs'
opt.ignorecase = true
opt.smartcase = true
opt.cindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.showmatch = true
opt.matchtime = 3
opt.updatetime = 100
opt.splitbelow = true
opt.splitright = true
opt.foldlevelstart = 0
opt.hidden = true
opt.cursorline = true
opt.switchbuf = 'usetab'
opt.scrolloff = 1
opt.completeopt = {'menuone', 'noselect'}
opt.pumheight = 10
opt.fillchars = {vert = '┃', diff = ' ', fold = ' ', eob = ' '}
opt.complete = opt.complete:append {'i'}
opt.clipboard = 'unnamedplus'
opt.guicursor = ''
opt.signcolumn = 'yes:2'
opt.cmdheight = 2
opt.mouse = 'a'
opt.statusline = ' ' -- hide the default statusline on the first frames
opt.guifont = 'JetBrainsMono-Regular:h20'

-- VARIOUS -------------------------------------------------------
-- color scheme
cmd 'colorscheme espresso'
-- nvim as man pager
cmd 'runtime ftplugin/man.vim'
-- map leader
g.mapleader = ','

-- MAPPINGS ------------------------------------------------------
-- c'est en forgeant que l'on devient forgeron
map('', '<Up>', '<Nop>')
map('', '<Down>', '<Nop>')
map('', '<Right>', '<Nop>')
map('', '<Left>', '<Nop>')
-- move fast with Ctrl + hjkl
map('', '<C-l>', '<Plug>SaeRight', {noremap=false})
map('', '<C-h>', '<Plug>SaeLeft', {noremap=false})
map('', '<C-j>', '<C-d>')
map('', '<C-k>', '<C-u>')
-- move through wrapped line
map('', 'j', 'gj', {silent=true})
map('', 'k', 'gk', {silent=true})
-- goto start and end of line
map('', '<space>l', '$')
map('', '<space>h', '0')
-- work inner by default
map('o', 'w', 'iw')
-- search and replace
map('v', '<Leader>f', '<Esc>:%s/\\%V')
map('n', '<Leader>f', ':%s/')
-- hide highlight after a search
map('n', '<space>', ':nohlsearch<CR>', {silent=true})
-- show trailing whitespaces
map('n', '<Leader><Space>', '/\\s\\+$<CR>')
-- tabs
map('n', '<Leader>t', ':tabnew<CR>')
map('', '<C-Right>', ':tabn<CR>', {silent=true})
map('', '<C-Left>', ':tabp<CR>', {silent=true})
map('', '<C-Up>', ':+tabmove<CR>', {silent=true})
map('', '<C-Down>', ':-tabmove<CR>', {silent=true})
-- windows
map('n', '<Leader>s', ':new<CR>', {silent=true})
map('n', '<Leader>v', ':vnew<CR>', {silent=true})
map('n', '<Leader><S-s>', ':split<CR>', {silent=true})
map('n', '<Leader><S-v>', ':vsplit<CR>', {silent=true})
map('n', '<A-h>', '<C-w>h', {silent=true})
map('n', '<A-l>', '<C-w>l', {silent=true})
map('n', '<A-j>', '<C-w>j', {silent=true})
map('n', '<A-k>', '<C-w>k', {silent=true})
map('n', '<A-Up>', ':resize +4<CR>', {silent=true})
map('n', '<A-Down>', ':resize -4<CR>', {silent=true})
map('n', '<A-Right>', ':vertical resize +4<CR>', {silent=true})
map('n', '<A-Left>', ':vertical resize -4<CR>', {silent=true})
-- terminal normal mode
map('t', '<Leader>n', '<C-\\><C-N>')

-- AUTOCOMMANDS --------------------------------------------------
-- see https://github.com/neovim/neovim/pull/12378
cmd([[
  augroup init.lua
    autocmd!
    " whenever CursorHold is fired (nothing typed during 'updatetime') in a normal
    " bufer (&buftype option is empty) run checktime to refresh the buffer and
    " retrieve any external changes
    autocmd CursorHold * if empty(&buftype) | checktime % | endif
    autocmd FileType man set nonumber
  augroup END
]])

-- ponton.nvim ---------------------------------------------------
hi('StatusLineNC', '#BDAE9D', '#432717')
hi('VertSplit', '#2A190E', nil)
local line_bg = '#432717'
require'ponton'.setup({
  line = {'active_mark_start', 'mode', 'buffer_name', 'buffer_changed',
    'read_only', 'git_branch', 'spacer', 'lsp_status', 'lsp_error',
    'lsp_warning', 'lsp_information', 'lsp_hint', 'line', 'sep',
    'column', 'line_percent', 'active_mark_end'},
  segments = {
    mode = {
      map = {
        normal = {'▲', {'#BDAE9D', line_bg, 'bold'}},
        insert = {'◆', {'#049B0A', line_bg, 'bold'}},
        replace = {'◆', {'#C75450', line_bg, 'bold'}},
        visual = {'◆', {'#43A8ED', line_bg, 'bold'}},
        v_line = {'━', {'#43A8ED', line_bg, 'bold'}},
        v_block = {'■', {'#43A8ED', line_bg, 'bold'}},
        select = {'■', {'#3592C4', line_bg, 'bold'}},
        command = {'▼', {'#BDAE9D', line_bg, 'bold'}},
        shell_ex = {'●', {'#93896C', line_bg, 'bold'}},
        terminal = {'●', {'#049B0A', line_bg, 'bold'}},
        prompt = {'▼', {'#BDAE9D', line_bg, 'bold'}},
        inactive = {' ', {line_bg, line_bg}},
      },
      margin = {1, 1},
    },
    buffer_name = {
      style = {'#BDAE9D', '#2A190E', 'bold'},
      empty = nil,
      padding = {1, 1},
      margin = {1, 1},
      decorator = {'', '', {'#2A190E', line_bg}},
      condition = require'ponton.condition'.buffer_not_empty
    },
    buffer_changed = {
      style = {'#DF824C', line_bg, 'bold'},
      value = '†',
      padding = {nil, 1},
    },
    read_only = {
      style = {'#C75450', line_bg, 'bold'},
      value = '',
      padding = {nil, 1},
      condition = require'ponton.condition'.is_read_only
    },
    spacer = {
      style = {line_bg, line_bg},
    },
    sep = {
      style = {'#BDAE9D', line_bg},
      text = '⏽',
    },
    line_percent = {
      style = {'#BDAE9D', line_bg},
      padding = {nil, 1},
    },
    line = {
      style = {'#BDAE9D', line_bg},
      padding = {1},
    },
    column = {
      style = {'#BDAE9D', line_bg},
      left_adjusted = true,
      padding = {nil, 1},
    },
    git_branch = {
      style = {'#C5656B', line_bg},
      padding = {1, 1},
      prefix = ' ',
    },
    lsp_status = {
      style = {'#C5656B', line_bg},
      fn = require'lsp_status'.status,
      padding = {nil, 2},
      prefix = '󰣪 ',
    },
    lsp_error = {
      style = {'#FF0000', line_bg, 'bold'},
      padding = {nil, 1},
      prefix = '×',
    },
    lsp_warning = {
      style = {'#FFFF00', line_bg, 'bold'},
      padding = {nil, 1},
      prefix = '•',
    },
    lsp_information = {
      style = {'#FFFFCC', line_bg},
      padding = {nil, 1},
      prefix = '~',
    },
    lsp_hint = {
      style = {'#F49810', line_bg},
      padding = {nil, 1},
      prefix = '~',
    },
    active_mark_start = {
      style = {{'#DF824C', line_bg}, {line_bg, line_bg}},
      text = '▌',
    },
    active_mark_end = {
      style = {{'#DF824C', line_bg}, {line_bg, line_bg}},
      text = '▐',
    },
  },
})

-- kommentary ----------------------------------------------------
g.kommentary_create_default_mappings = false
map('n', '<leader>cc', '<Plug>kommentary_line_default', {noremap=false})
map('n', '<leader>c', '<Plug>kommentary_motion_default', {noremap=false})
map('v', '<leader>c', '<Plug>kommentary_visual_default', {noremap=false})

-- coBra ---------------------------------------------------------
g.coBraPairs = {
  rust = {
    {'<', '>'},
    {'"', '"'},
    {'{', '}'},
    {'(', ')'},
    {'[', ']'}
  }
}

-- neovide -------------------------------------------------------
g.neovide_cursor_animation_length = 0.08
g.neovide_cursor_trail_length = 0.6

-- OTerm ---------------------------------------------------------
map('n', '<Leader>o', '<Plug>OTerm', {noremap=false})

-- fzfTools ------------------------------------------------------
g.fzfTools = {
  gitlog = {tab = 1},
  gitlogsel = {tab = 1},
}
map('n', '<C-s>', '<Plug>Ls', {noremap=false})
map('n', '<C-g>', '<Plug>GitLog', {noremap=false})
map('n', '<C-g>', '<Plug>SGitLog', {noremap=false})

-- nvim-tree.lua -------------------------------------------------
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
g.nvim_tree_width = 40
g.nvim_tree_git_hl = 1
g.nvim_tree_width_allow_resize = 1
map('n', '<Tab>', '<cmd>NvimTreeToggle<CR>')
map('n', '<S-Tab>', '<cmd>NvimTreeFindFile<CR>')
vim.g.nvim_tree_bindings = {
  ['<CR>']           = tree_cb('edit'),
  ['o']              = tree_cb('edit'),
  ['<2-LeftMouse>']  = tree_cb('edit'),
  ['<2-RightMouse>'] = tree_cb('cd'),
  ['<C-]>']          = tree_cb('cd'),
  ['<C-v>']          = tree_cb('vsplit'),
  ['<C-s>']          = tree_cb('split'),
  ['<C-t>']          = tree_cb('tabnew'),
  ['<BS>']           = tree_cb('close_node'),
  ['<S-CR>']         = tree_cb('close_node'),
  ['<C-p>']          = tree_cb('preview'),
  ['I']              = tree_cb('toggle_ignored'),
  ['H']              = tree_cb('toggle_dotfiles'),
  ['R']              = tree_cb('refresh'),
  ['a']              = tree_cb('create'),
  ['d']              = tree_cb('remove'),
  ['r']              = tree_cb('rename'),
  ['<C-r>']          = tree_cb('full_rename'),
  ['x']              = tree_cb('cut'),
  ['c']              = tree_cb('copy'),
  ['p']              = tree_cb('paste'),
  ['-']              = tree_cb('dir_up'),
  ['q']              = tree_cb('close'),
}
g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
}
g.nvim_tree_icons = {
  symlink =        '󰌹',
  folder = {
    arrow_open =   '▼',
    arrow_closed = '▶',
    default =      '▶',
    open =         '▼',
    empty =        '▷',
    empty_open =   '▽',
    symlink =      '󰌹 ▶',
    symlink_open = '󰌹 ▼',
  },
  git = {
    unstaged =     '✗',
    staged =       '✓',
    unmerged =     '⏼',
    renamed =      '→',
    untracked =    '•',
    deleted =      '-',
    ignored =      '⭘',
  },
}
li('NvimTreeRootFolder', 'Comment')
li('NvimTreeExecFile', 'Todo')
li('NvimTreeSpecialFile', 'Function')
li('NvimTreeFolderIcon', 'Constant')
li('NvimTreeImageFile', 'Normal')
li('NvimTreeGitIgnored', 'Debug')
hi('NvimTreeGitNew', '#42905b', nil, 'italic')
hi('NvimTreeGitStaged', '#39c064', nil, 'italic')
hi('NvimTreeGitRenamed', '#507eae', nil, 'italic')
hi('NvimTreeGitDeleted', '#bd5b5b', nil, 'italic')
li('NvimTreeGitDirty', 'NvimTreeGitDeleted')

-- nvim-treesitter -----------------------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp', 'rust', 'yaml', 'bash', 'typescript',
    'javascript', 'html', 'css', 'lua', 'comment', 'jsdoc', 'tsx',
    'toml', 'json', 'graphql', 'jsonc'},
  highlight = {enable = true},
  indent = {enable = true},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'tn',
      node_incremental = '<A-l>',
      scope_incremental = '<A-j>',
      node_decremental = '<A-h>',
    },
  },
}

-- LSP -----------------------------------------------------------
local lspconfig = require'lspconfig'
local lsp_status = require'lsp_status'
lsp_status.setup()

fn.sign_define('LspDiagnosticsSignError', {text = '▬', texthl = 'LspDiagnosticsSignError'})
fn.sign_define('LspDiagnosticsSignWarning', {text = '▬', texthl = 'LspDiagnosticsSignWarning'})
fn.sign_define('LspDiagnosticsSignInformation', {text = '▬', texthl = 'LspDiagnosticsSignInformation'})
fn.sign_define('LspDiagnosticsSignHint', {text = '▬', texthl = 'LspDiagnosticsSignHint'})

map('n', '<A-a>', '<cmd>lua vim.lsp.diagnostic.goto_prev{popup_opts={show_header=false}}<CR>')
map('n', '<A-z>', '<cmd>lua vim.lsp.diagnostic.goto_next{popup_opts={show_header=false}}<CR>')
map('v', '<A-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
map('n', '<A-t>', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<A-d>', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<A-r>', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<A-g>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<A-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>')

local function on_attach(client, bufnr)
  if client.resolved_capabilities.document_range_formatting then
    map('n', '<A-f>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  elseif client.resolved_capabilities.document_formatting then
    map('n', '<A-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  end
  -- open a floating window with the diagnostics from the current cursor position
  cmd([[
    augroup lsp_on_attach
      autocmd!
      autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics{show_header=false, focusable = false}
    augroup END
  ]])
  -- highlight the symbol under the cursor
  if client.resolved_capabilities.document_highlight then
    cmd([[
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
  lsp_status.on_attach(client, bufnr)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

local capabilities = lsp_status.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

lspconfig.clangd.setup {                           -- C, C++
  on_attach = on_attach,
  capabilities = capabilities
}
lspconfig.tsserver.setup {                         -- TypeScript
  on_attach = on_attach,
  capabilities = capabilities
}
lspconfig.rust_analyzer.setup {                    -- Rust
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer.checkOnSave.command'] = 'clippy',
  }
}
lspconfig.sumneko_lua.setup {                      -- Lua
  on_attach = on_attach,
  capabilities = capabilities,
  -- must be installed in /opt/lua-language-server
  cmd = {'/opt/lua-language-server/bin/Linux/lua-language-server', '-E', '/opt/lua-language-server/main.lua'},
  settings = {
    Lua = {
      runtime = {
        -- LuaJIT for Neovim
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data
      telemetry = {
        enable = false,
      }
    }
  }
}

-- telescope.nvim ------------------------------------------------
local actions = require('telescope.actions')
require'telescope'.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    mappings = {
      i = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<esc>'] = actions.close, -- <Esc> quit in insert mode
      },
    },
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  }
}

map('', '<A-s>', '<cmd>Telescope lsp_document_symbols<cr>')
map('', '<A-w>', '<cmd>Telescope lsp_workspace_symbols<cr>')
map('', '<A-u>', '<cmd>Telescope lsp_references<cr>')
map('', '<A-CR>', '<cmd>lua require"lens".lsp_code_actions()<cr>')
map('', '<A-q>', '<cmd>Telescope lsp_document_diagnostics<cr>')
map('', '<A-S-q>', '<cmd>Telescope lsp_workspace_diagnostics<cr>')
map('', '<A-b>', '<cmd>Telescope lsp_definitions<cr>')
map('', '<C-f>', '<cmd>Telescope live_grep<cr>')
map('', '<C-b>', '<cmd>lua require"lens".buffers()<cr>')
cmd 'hi! link TelescopeBorder NonText'

-- lsp_extensions.nvim -------------------------------------------
-- enable inlay hints for Rust
cmd([[
  augroup lsp_inlay_hints
    autocmd!
    autocmd CursorHold,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{highlight="Hint", prefix=""}
  augroup END
]])

-- nvim-compe ----------------------------------------------------
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    snippets_nvim = {priority = 100000},
  }
}

local function check_back_space()
  local col = fn.col('.') - 1
  if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

function _G.tab_complete()
  if fn.pumvisible() == 1 then
    return t'<C-n>'
  elseif check_back_space() then
    return t'<Tab>'
  else
    return fn['compe#complete']()
  end
end

function _G.s_tab_complete()
  if fn.pumvisible() == 1 then
    return t'<C-p>'
  else
    return t'<S-Tab>'
  end
end

map('i', '<Tab>', 'v:lua.tab_complete()', {expr=true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr=true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr=true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr=true})
map('i', '<C-Space>', 'compe#complete()', {silent=true, expr=true})
map('i', '<CR>', "compe#confirm('<CR>')", {silent=true, expr=true})
map('i', '<C-e>', "compe#close('<C-e>')", {silent=true, expr=true})

-- snippets.nvim -------------------------------------------------
-- use <C-j> <C-k> (insert mod) to expand snippets
require'snippets'.use_suggested_mappings()
local js_log = {log = [[console.log('$0');]]}
require'snippets'.snippets = {
  javascript = js_log,
  typescript = js_log,
  typescriptreact = js_log,
  c = {
    printf = [[printf("$1 -> %s$0\n", $1);]]
  },
  rust = {
    pprintln = [[println!("$1 -> {:#?}", $1);]]
  },
}

-- ALE -----------------------------------------------------------
g.ale_disable_lsp = 1
g.ale_sign_error = '▬'
g.ale_sign_warning = '▬'
g.ale_sign_info = '▬'
g.ale_sign_style_error = '▬'
g.ale_sign_style_warning = '▬'
g.ale_set_highlights = 0
g.ale_echo_msg_error_str = 'E'
g.ale_echo_msg_warning_str = 'W'
g.ale_echo_msg_info_str = 'I'
g.ale_echo_msg_format = '[%linter%][%severity%] %s'
g.ale_linters_explicit = 1
g.ale_completion_autoimport = 1
g.ale_fixers = {
  javascript = {'eslint', 'prettier'},
  json = {'eslint'},
  typescript = {'eslint', 'prettier'},
  typescriptreact = {'eslint', 'prettier'},
  graphql = {'eslint'},
  rust = {'rustfmt'}
}
g.ale_linters = {
  javascript = {'eslint'},
  json = {'eslint'},
  typescript = {'eslint', 'tsserver'},
  typescriptreact = {'eslint', 'tsserver'},
  graphql = {'eslint '},
  sh = {'shellcheck'}
}
cmd 'hi! link ALEError Error'
cmd 'hi! link ALEWarning Warning'
cmd 'hi! link ALEInfo Information'
cmd 'hi! link ALEErrorSign ErrorSign'
cmd 'hi! link ALEWarningSign WarningSign'
cmd 'hi! link ALEInfoSign InformationSign'
map('', '<A-e>', '<Plug>(ale_fix)', {noremap=false})
map('', '<A-(>', '<Plug>(ale_previous_wrap)', {noremap=false})
map('', '<A-->', '<Plug>(ale_next_wrap)', {noremap=false})

-- gitsigns.nvim -------------------------------------------------
require'gitsigns'.setup {
  signs = {
    add          = {hl = 'GitAddSign'   , text = '┃'},
    change       = {hl = 'GitChangeSign', text = '┃'},
    delete       = {hl = 'GitDeleteSign', text = '▶'},
    topdelete    = {hl = 'GitDeleteSign', text = '▶'},
    changedelete = {hl = 'GitChangeDeleteSign', text = '┃'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    noremap = true,
    buffer = true,
    ['n <Leader>n'] = { expr = true, "&diff ? '<Leader>n' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n <Leader>b'] = { expr = true, "&diff ? '<Leader>b' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  },
}
