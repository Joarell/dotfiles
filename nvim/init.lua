--  ╭──────────────────────────────────────────────────────────╮
--  │                         Settings                         │
--  ╰──────────────────────────────────────────────────────────╯

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins")
require("luasnip_config")
require("popup")
require("tscope")
require("keybindings")
require("appearance")
require("nvim-ts-autotag").setup()
require("troublesettings")
require("neoscroll").setup()
require("nvim_comment").setup()
require("vgit_config")
require("tmux").setup()
require("dap_config")
require("commands_nvim")

local cursor = pcall(require, "cursor_style")
if cursor then
	require("cursor_style")
end


-- Disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                            Format settings-                            │
--  ╰────────────────────────────────────────────────────────────────────────╯

local set = vim.opt

set.spell = true
set.number = true
set.relativenumber = true
set.sps = "best"
set.updatetime = 200
set.signcolumn = "yes"
set.completeopt = { "menu", "menuone", "noselect" }
set.pumheight = 20
set.showmode = false
set.timeoutlen = 150
set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 4
set.expandtab = false
set.mouse = "a"
set.ignorecase = true
set.smartcase = true
set.wrap = true
set.cursorline = true
set.autoindent = true
set.smartindent = true
set.autowrite = true
set.swapfile = false
set.undofile = true
set.termguicolors = true
set.winblend = 30
set.clipboard = ""
set.wildmenu = true
set.inccommand = split --Shows replacements in a split screen, before applying to the fileset.scroll = 10
set.guifont = "CaskaydiaCove NF:h9"

vim.wo.colorcolumn = "80"
vim.g["zoom#statustext"] = "Z"
vim.g["netrw_keepdir"] = 0
vim.g["netrw_winsize"] = 30
vim.g["netrw_banner"] = 0
vim.g["netrw_localcopydircmd"] = "cp -r"
vim.g["load_netrw"] = 1
vim.g["load_netrwPlugin"] = 1
vim.o.fcs = "eob: "
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.o.incsearch = false

--  ╭─────────────────────────────────────────────────────────────────────────╮
--  │                             Commands setup                              │
--  ╰─────────────────────────────────────────────────────────────────────────╯
-- nvim_create_user_command expects three arguments:

--     Name of the command. It must begin with an uppercase letter.
--     Command. Can be a string or a lua function.
--     Attributes. A lua table with the options for our command. You can find
-- 	   details in the documentation :help nvim_create_user_command() and also
--     :help command-attributes.

--Ex:
vim.api.nvim_create_user_command("ProjectFiles", function(input)
	vim.call("fzf#vim#files", "~/projects", input.bang)
end, { bang = true, desc = "Search projects folder" })

-- Highlight on yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ {
			higroup = "IncSearch",
			timeout = 20,
		} })
	end,
})

vim.api.nvim_create_user_command("AutoRun", function()
	print("Running...")
end, {})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["testDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

vim.diagnostic.config({ float = { border = "rounded" } })

-- TODO: - open a terminal without number column nativily.
-- local newbuf = vim.api.nvim_create_buf(unlisted, true)
-- vim.api.nvim_open_win(newbuf, vim.cmd ("term"), {
-- 	relative = "win",
-- 	width = 300,
-- 	height = 80,
-- 	bufpos = {
-- 		10,
-- 		40,
-- 	},
-- 	border = "rounded",
-- })

--###########################################################################--
-- 							Neovide settings 								 --
--###########################################################################--
-- vim.cmd([[
-- 	set guifont=CaskaydiaCove\ NF:h08.5
-- ]])

vim.g.neovide_transparency = 0.9
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_refresh_rate = 60
vim.g.neovide_scroll_animation_length = 0.3
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_underline_automatic_sacaling = true
-- vim.g.neovide_cursor_animation_length = 0.13
-- vim.g.neovide_cursor_animate_in_insert_mode = true

--###########################################################################--
-- 							color settings									 --
--###########################################################################--
-- Attaches to every FileType mode
local high_str = require("high-str")

high_str.setup({
	verbosity = 0,
	saving_path = "/tmp/highstr/",
	highlight_colors = {
		-- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
		color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
		color_1 = { "#ff8800", "smart" }, -- Pastel yellow
		color_2 = { "#00ffaa", "smart" }, -- Aqua menthe
		color_3 = { "#8A2BE2", "smart" }, -- Proton purple
		color_4 = { "#FF4500", "smart" }, -- Orange red
		color_5 = { "#008000", "smart" }, -- Office green
		color_6 = { "#0000FF", "smart" }, -- Just blue
		color_7 = { "#FFC0CB", "smart" }, -- Blush pink
		color_8 = { "#59a0e5", "smart" }, -- Cosmic latte
		color_9 = { "#0080ff", "smart" }, -- Follow brown
	},
})

--###########################################################################--
-- 							Discord app monitor								 --
--###########################################################################--

require("presence"):setup({
	-- General options
	auto_update = true,                          -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
	neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
	main_image = "neovim",                       -- Main image display (either "neovim" or "file")
	client_id = "793271441293967371",            -- Use your own Discord application client id (not recommended)
	log_level = nil,                             -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
	debounce_timeout = 10,                       -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
	enable_line_number = false,                  -- Displays the current line number instead of the current project
	blacklist = {},                              -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
	buttons = true,                              -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`,
	file_assets = {},                            -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
	-- Rich Presence text options
	editing_text = "Editing %s",                 -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text = "Browsing %s",          -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
	git_commit_text = "Committing changes",      -- Format string rendered when committing changes in git (either string or function(filename: string): string)
	plugin_manager_text = "Managing plugins",    -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
	reading_text = "Reading %s",                 -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: st
	workspace_text = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): s
	line_number_text = "Line %s out of %s",      -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line
	21,
})

--###########################################################################--
-- 							Setting TODO comments 							 --
--###########################################################################--
require("todo-comments").setup({
	signs = true,   -- show icons in the signs column
	sign_priority = 8, -- sign priority
	-- UPDATE:keywords recognized as todo comments
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO", "UPDATE", "INSIDE" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	gui_style = {
		fg = "NONE",    -- The gui style to use for the fg highlight group.
		bg = "BOLD",    -- The gui style to use for the bg highlight group.
	},
	merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		multiline = true,          -- enable multine todo comments
		multiline_pattern = "^.",  -- lua pattern to match the next multiline from the start of the matched keyword
		multiline_context = 10,    -- extra lines that will be re-evaluated when changing a line
		before = "",               -- "fg" or "bg" or empty
		keyword = "wide",          -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		after = "fg",              -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true,      -- uses treesitter to match keywords in comments only
		max_line_len = 400,        -- ignore lines longer than this
		exclude = {},              -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of highlight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		-- regex that will be used to match keywords.
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
	},
})
