--###########################################################################--
-- 							Settings		 								 --
--###########################################################################--
require("luasnippets")
require("null_ls")
require("popup")
require("float_window")
require("tscope")
require("keybindings")
require("starter")
require("appearance")
require("nvim-ts-autotag").setup()
require("troublesettings")
require("lspsettings")
require("plugins")
require("neoscroll").setup()
require("nvim_comment").setup()
require("vgit").setup({})

-- Disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--###########################################################################--
--							Format settings									--
--###########################################################################--
local set = vim.opt

set.spellsuggest = en
set.updatetime = 200
set.signcolumn = "yes"
set.guifont = "monospace:h17"
set.completeopt = { "menu", "menuone", "noselect" }
set.pumheight = 10
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
set.title = true
set.undofile = true
set.termguicolors = true
set.winblend = 30
set.clipboard = ""
set.wildmenu = true
set.inccommand = split --Shows replacements in a split screen, before applying to the file


vim.wo.colorcolumn = "80"
vim.bo.filetype = "lua"
vim.g["zoom#statustext"] = "Z"
vim.wo.fillchars = "eob: "
vim.diagnostic.config({ virtual_text = false }) -- disable all notifications on the code field.


--###########################################################################--
-- 							Commands setup									 --
--###########################################################################--
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

--###########################################################################--
-- 							Neovide settings 								 --
--###########################################################################--
vim.cmd([[

	noremap <yy> "ay
	nmap <p> "ap

	set guifont=MesloLGSDZ\ NF:h08
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

--###########################################################################--
-- 							color settings									 --
--###########################################################################--
-- Attaches to every FileType mode
require("colorizer").setup()

local high_str = require("high-str")

high_str.setup({
	verbosity = 0,
	saving_path = "/tmp/highstr/",
	highlight_colors = {
		-- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
		color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
		color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
		color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
		color_3 = { "#8A2BE2", "smart" }, -- Proton purple
		color_4 = { "#FF4500", "smart" }, -- Orange red
		color_5 = { "#008000", "smart" }, -- Office green
		color_6 = { "#0000FF", "smart" }, -- Just blue
		color_7 = { "#FFC0CB", "smart" }, -- Blush pink
		color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
		color_9 = { "#7d5c34", "smart" }, -- Follow brown
	},
})

--###########################################################################--
-- 							Discord app monitor								 --
--###########################################################################--

require("presence"):setup({
	-- General options
	auto_update         = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
	neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
	main_image          = "neovim", -- Main image display (either "neovim" or "file")
	client_id           = "793271441293967371", -- Use your own Discord application client id (not recommended)
	log_level           = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
	debounce_timeout    = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
	enable_line_number  = false, -- Displays the current line number instead of the current project
	blacklist           = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
	buttons             = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`,
	file_assets         = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
	-- Rich Presence text options
	editing_text        = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text  = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
	git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
	plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
	reading_text        = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: st
	workspace_text      = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): s
	line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line
	21
})
