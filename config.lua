--Testando
--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
--File path

-- ~/.local/share/lunarvim/lvim/lua/lvim/plugins.lua
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
vim.opt.showtabline = 2
-- lvim.colorscheme = "base16-helios"
lvim.colorscheme = "onedarker"
-- Lua
lvim.lsp.diagnostics.virtual_text = true
lvim.transparent_window = true
-- lvim.autocommands = {
-- 	set guicursor = n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
-- 	  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
-- 	  \,sm:block-blinkwait175-blinkoff150-blinkon175,
-- },
-- separator_style = "slant", {'any', 'any'},


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<leader>bl"] = ":EnableBlameLine<cr>"
lvim.keys.normal_mode["<leader>bd"] = ":DisableBlameLine<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<F1>"] = ":RnvimrToggle<cr>"
lvim.keys.normal_mode["<F2>"] = ":call vimspector#ClearLineBreakpoint()<cr>"
lvim.keys.normal_mode["<F4>"] = ":call vimspector#Reset()<cr>"
lvim.keys.normal_mode["<F5>"] = ":call vimspector#Continue()<cr>"
lvim.keys.normal_mode["<F6>"] = ":!gcc -Wall -Werror -Wextra -g -D BUFFER_SIZE= <C-r>% -o test <Up>"
lvim.keys.normal_mode["<F7>"] = ":call vimspector#StepOver()<cr>"
lvim.keys.normal_mode["<F8>"] = ":TagbarToggle<cr>"
lvim.keys.normal_mode["<F9>"] = ":call vimspector#ToggleBreakpoint()<cr>"
lvim.keys.normal_mode["<F10>"] = ":call vimspector#StepOver()<cr>"
lvim.keys.normal_mode["<F11>"] = ":call vimspector#Continue()<cr>"
lvim.keys.normal_mode["<F12>"] = ":lua vim.lsp.buf.format()<CR>"
lvim.keys.normal_mode["<leader>r"] = ":call vimspector#Restart()<cr>"
lvim.keys.normal_mode["<leader>R"] = ":TSBufEnable rainbow<cr>"
lvim.keys.normal_mode["<leader>d"] = ":call vimspector#ClearBreakpoints()<cr>"
lvim.keys.normal_mode["<leader>m"] = ":mksession!"
lvim.keys.normal_mode["<leader>ss"] = ":split <CR>"
lvim.keys.normal_mode["<leader>vv"] = ":vsplit <CR>"
lvim.keys.normal_mode["<leader>p"] = ":!vivaldi-stable % &<CR>"
lvim.keys.normal_mode["<PageUp>"] = ":m .-2<cr>=="
lvim.keys.normal_mode["<PageDown>"] = ":m .+<cr>=="

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}

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
	n = { ":!norminette <C-r>% <cr>", "Norminette" },
	p = { "<cmd>:packadd termdebug<cr>", "adding termdebug" },
	t = { ":Termdebug test", "Termdebug <CR>" },
}

lvim.builtin.which_key.mappings["G"] = {
	name = "GitHub",
	g = { "<cmd>:G<cr>", "Git status" },
	c = { "<cmd>:G commit<cr>", "Commit" },
	p = { "<cmd>:G push<cr>", "Push" },
}
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

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
	"html",
	"rust",
	"java",
	"yaml",
	"markdown",
	"kotlin",
	"rust",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
require('neoscroll').setup()
require('scrollbar').setup()


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

-- The setup config table shows all available config options with their default values:
require("presence"):setup({
	-- General options
	auto_update        = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
	neovim_image_text  = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
	main_image         = "lvim", -- Main image display (either "neovim" or "file")
	client_id          = "793271441293967371", -- Use your own Discord application client id (not recommended)
	log_level          = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
	debounce_timeout   = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
	enable_line_number = false, -- Displays the current line number instead of the current project
	blacklist          = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
	buttons            = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
	file_assets        = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

	-- Rich Presence text options
	editing_text        = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text  = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
	git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
	plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
	reading_text        = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
	workspace_text      = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
	line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

--Treesitter Context
require 'treesitter-context'.setup {
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
		-- For all filetypes
		-- Note that setting an entry here replaces all other patterns for this entry.
		-- By setting the 'default' entry below, you can control which nodes you want to
		-- appear in the context window.
		default = {
			'class',
			'function',
			'method',
			'for',
			'while',
			'if',
			'switch',
			'case',
		},
		-- Patterns for specific filetypes
		-- If a pattern is missing, *open a PR* so everyone can benefit.
		tex = {
			'chapter',
			'section',
			'subsection',
			'subsubsection',
		},
		rust = {
			'impl_item',
			'struct',
			'enum',
		},
		scala = {
			'object_definition',
		},
		vhdl = {
			'process_statement',
			'architecture_body',
			'entity_declaration',
		},
		markdown = {
			'section',
		},
		elixir = {
			'anonymous_function',
			'arguments',
			'block',
			'do_block',
			'list',
			'map',
			'tuple',
			'quoted_content',
		},
		json = {
			'pair',
		},
		yaml = {
			'block_mapping_pair',
		},
	},
	exact_patterns = {
		-- Example for a specific filetype with Lua patterns
		-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
		-- exactly match "impl_item" only)
		-- rust = true,
	},

	-- [!] The options below are exposed but shouldn't require your attention,
	--     you can safely ignore them.

	zindex = 20, -- The Z-index of the context window
	mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
}

-- set additional linters
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
		filetypes = { "javascript", "python" },
	},
}

-- Attaches to every FileType mode
require 'colorizer'.setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
	'css';
	'javascript';
	html = {
		mode = 'foreground';
	}
}

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup({
	'css';
	'javascript';
	html = { mode = 'background' };
}, { mode = 'foreground' })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup {
	'*'; -- Highlight all files, but customize some others.
	css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
	html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

-- Exclude some filetypes from highlighting by using `!`
require 'colorizer'.setup {
	'*'; -- Highlight all files, but customize some others.
	'!vim'; -- Exclude vim from highlighting.
	-- Exclusion Only makes sense if '*' is specified!
}


-- Additional Plugins
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
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
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "tomasiser/vim-code-dark" },
	{ "preservim/tagbar" },
	{ "szw/vim-maximizer" },
	{ "karb94/neoscroll.nvim" },
	{ "puremourning/vimspector" },
	{ "chriskempson/base16-vim" },
	{ "tpope/vim-fugitive" },
	{ "nvim-treesitter/playground" },
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "sainnhe/everforest" },
	{ "alvan/vim-closetag" },
	{ "tveskag/nvim-blame-line" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "p00f/nvim-ts-rainbow" },
	{ "petertriho/nvim-scrollbar" },
	{ "andweeb/presence.nvim" },
	{ "Lokaltog/neoranger" },
	{ "shime/vim-livedown" },
	{ "kevinhwang91/rnvimr" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "norcalli/nvim-colorizer.lua" },
}


vim.cmd([[

	noremap <yy> "ay
	nmap <p> "ap

	set guifont=CodeNewRoman\ NF:h09
	let g:neovide_transparency=0.8
	set number
	set relativenumber
	let g:neovide_no_idle=v:true
	let g:neovide_input_use_logo = v:true
	let g:neovide_cursor_vfx_mode = "sonicboom"
	let g:neovide_touch_drag_timeout = 0.17
	let g:neovide_touch_deadzone = 6.0
	let g:neovide_underline_automatic_scaling = v:true
	let g:neovide_hide_mouse_when_typing = v:false
	let g:neovide_cursor_vfx_mode = "pixiedust"
	set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
	  \,sm:block-blinkwait175-blinkoff150-blinkon175,
]])

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
