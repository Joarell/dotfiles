--Testando
--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
--File path
-- ~/.local/share/lunarvim/lvim/lua/lvim/config/settings.lua
-- ~/.local/share/lunarvim/lvim/lua/lvim/plugins.lua
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
vim.opt.showtabline = 2
-- lvim.colorscheme = "base16-helios"
lvim.colorscheme = "onedarker"
-- Lua
lvim.lsp.diagnostics.virtual_text = false
lvim.transparent_window = true
-- separator_style = "slant", {'any', 'any'},


vim.cmd([[
    nnoremap <Leader>h :Stdheader<cr>
    "<silent><F3> :MaximizerToggle<cr>"
    nnoremap <Leader>m :mksession!
    nnoremap <Leader>gj :diffget //3<cr>
    nnoremap <Leader>gf :diffget //2<cr>
    nnoremap <PageDown> :m .+<cr>==
    nnoremap <PageUp> :m .-2<cr>==
    nmap <F8> :TagbarToggle<cr>"
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
    nnoremap <Leader>u  :VimspectorUpdate<cr>
    "let g:vimspector_enable_mappings = 'HUMAN'"
    "let g:vimspector_enable_mappings = 'VISUAL_STUDIO'"
    "let g:maximizer_set_default_mapping = 1"
    "let g:codedark_term256 = 1"
    "let g:termdebug_wide = 100"
    "let g:termdebug_popup = 0"
	"let g:rainbow_active = 1"
	"let g:neovide_cursor_antialiasing=v:true"
]])

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<F2>"] = ":call vimspector#ClearLineBreakpoint()<cr>"
lvim.keys.normal_mode["<F4>"] = ":call vimspector#Reset()<cr>"
lvim.keys.normal_mode["<F5>"] = ":call vimspector#Continue()<cr>"
lvim.keys.normal_mode["<F6>"] = ":!gcc -Wall -Werror -Wextra -g -D BUFFER_SIZE= <C-r>% -o test <Up>"
lvim.keys.normal_mode["<F7>"] = ":call vimspector#StepOver()<cr>"
lvim.keys.normal_mode["<F9>"] = ":call vimspector#ToggleBreakpoint()<cr>"
lvim.keys.normal_mode["<F10>"] = ":call vimspector#StepOver()<cr>"
lvim.keys.normal_mode["<F11>"] = ":call vimspector#Continue()<cr>"
lvim.keys.normal_mode["<leader>r"] = ":call vimspector#Restart()<cr>"
lvim.keys.normal_mode["<leader>d"] = ":call vimspector#ClearBreakpoints()<cr>"
lvim.keys.normal_mode["<leader>m"] = ":mksession!"
lvim.keys.normal_mode["<leader>ss"] = ":split <CR>"
lvim.keys.normal_mode["<leader>vv"] = ":vsplit <CR>"
lvim.keys.normal_mode["<leader>p"] = ":!vivaldi-stable % &<CR>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
    --   i = {
--   j  ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
require('telescope').load_extension('media_files')
lvim.builtin.which_key.mappings["t"] = {
name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.builtin.which_key.mappings["D"] = {
    name = "Debuging",
    n = {":!norminette <C-r>% <cr>", "Norminette"},
    p = {"<cmd>:packadd termdebug<cr>", "adding termdebug"},
    t = {":Termdebug test", "Termdebug <CR>"},
}

lvim.builtin.which_key.mappings["G"] = {
    name = "GitHub",
    g = {"<cmd>:G<cr>", "Git status"},
    c = {"<cmd>:G commit<cr>", "Commit"},
    p = {"<cmd>:G push<cr>", "Push"},
}
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
require('neoscroll').setup()

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   -- { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = {"javascript", "python" },
  },
}

-- Additional Plugins
 lvim.plugins = {
     {"folke/tokyonight.nvim"},
     {
       "folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
		require("trouble").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
		}
	  end
     },
     {"lukas-reineke/indent-blankline.nvim"},
     {"tomasiser/vim-code-dark"},
     {"preservim/tagbar"},
     {"szw/vim-maximizer"},
     {"puremourning/vimspector"},
     {"chriskempson/base16-vim"},
     {"tomtom/tcomment_vim"},
     {"tpope/vim-fugitive"},
	 {"luochen1990/rainbow"},
	 {"ap/vim-css-color"},
	 {"nvim-treesitter/playground"},
	 {"nvim-telescope/telescope-media-files.nvim"},
	 {"karb94/neoscroll.nvim"},
	 {"sainnhe/everforest"},
	 {"alvan/vim-closetag"},
 }


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
vim.opt.timeoutlen = 200
