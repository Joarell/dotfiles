--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                            Format settings                             │
--  ╰────────────────────────────────────────────────────────────────────────╯
local set = vim.opt

set.cole = 1
set.encoding = 'utf-8'
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
-- set.undodir = vim.fn.stdpath("config") .. "/.undo"
set.termguicolors = true
set.winblend = 30
set.clipboard = ""
set.wildmenu = true
set.inccommand = split --Shows replacements in a split screen, before applying to the fileset.scroll = 10
-- set.guifont = "CaskaydiaCove NF:h13"
set.background = 'dark'
set.list = true
-- set.lcs:append({space = "·", eol = "↴", tab = "▎  "})

--  ╭──────────────────────────────────────────────────────────╮
--  │                         Settings                         │
--  ╰──────────────────────────────────────────────────────────╯

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = {
	ui = {
		border = "rounded",
	},
}

require("lazy").setup("plugins", opts)
require("luasnip_config")
require("popup")
require("tscope")
require("keybindings")
require("appearance")
require("nvim-ts-autotag").setup()
require("troublesettings")
-- require("vgit_config")
-- require("tmux").setup()
require("dap_config")
require("commands_nvim")

local cursor = pcall(require, "cursor_style")
if cursor then
	require("cursor_style")
end
-- Disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local html_format_tab = vim.api.nvim_create_augroup("Format", {})
local color_hl = vim.api.nvim_create_augroup("Dap_Set", {})
local diag = vim.api.nvim_create_augroup("Troubles", {})
local yaml = vim.api.nvim_create_augroup("YAML",{})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = {"*.yml"},
	callback = function()
		set.shiftwidth = 2
		set.softtabstop = 2
		set.tabstop = 2
		set.expandtab = true
	end,
	group = yaml,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.cmd("Trouble diagnostics")
	end,
	group = diag,
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.xml", "*.html", "*.css" },
	callback = function()
		-- vim.cmd("colorscheme solarized-osaka")
		require("lualine").setup()
		-- require("bufferline").setup()
		set.shiftwidth = 2
		set.softtabstop = 2
		set.tabstop = 2
		vim.wo.colorcolumn = "9999"
		vim.cmd("hi colorColumn guibg = #000000")
	end,
	group = html_format_tab,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "󱫪 ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
	end,
	group = color_hl,
})

-- vim.api.nvim_set_option("clipboard", "unnamed")
vim.wo.colorcolumn = "80"
vim.cmd("hi colorColumn guibg = #141E30")
vim.g.editorconfig = true
vim.g.transparecey = 0.8
vim.g["zoom#statustext"] = "Z"
vim.g["netrw_keepdir"] = 0
vim.g["netrw_winsize"] = 30
vim.g["netrw_banner"] = 0
vim.g["netrw_localcopydircmd"] = "cp -r"
vim.g["load_netrw"] = 1
vim.g["load_netrwPlugin"] = 1
vim.g["gradle_path"] = "/usr/bin/"
vim.o.incsearch = false
vim.o.fcs = "eob: ,foldopen:▾,foldsep:│,foldclose:▸"

vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" }
})
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

vim.diagnostic.enable(false)
vim.diagnostic.config({ float = { border = "rounded" } })

vim.diagnostic.config({
	virtual_text = {
		prefix = " 󱠇",
	},
})
--
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
local alpha = function()
	return string.format("%x", math.floor(255 * 0.8))
end

-- vim.g.neovide_floating_blur_amount_x = 2.0
-- vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_transparency = 0.899
-- vim.g.neovide_background_color = "#0F1117" .. alpha()
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_refresh_rate = 40
vim.g.neovide_scroll_animation_length = 0.3
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_underline_automatic_sacaling = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animation_far_lines = 1
vim.g.neovide_underline_stroke_scale = 0.8

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
-- 							Setting TODO comments 							 --
--###########################################################################--
require("todo-comments").setup({
	signs = true, -- show icons in the signs column
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
		fg = "NONE", -- The gui style to use for the fg highlight group.
		bg = "BOLD", -- The gui style to use for the bg highlight group.
	},
	merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		multiline = true, -- enable multine todo comments
		multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
		multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
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
