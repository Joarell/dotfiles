--###########################################################################--
-- 							Settings		 								 --
--###########################################################################--
require("popup")
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
-- require("bufferline").setup({})
require("mason").setup({
	ui = {
	icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--###########################################################################--
--							Format settings								     --
--###########################################################################--
local set = vim.opt

set.updatetime = 300
set.signcolumn = "yes"
set.guifont = "monospace:h17"
set.completeopt = { "menu", "menuone", "noselect" }
set.pumheight = 0
set.showmode = false
set.timeoutlen = 200
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
set.completeopt = { "menu", "menuone", "noselect" }
set.winblend = 0
set.clipboard = ""
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
			timeout = 40,
		} })
	end,
})

-- vim.api.nvim_create_augroup("lsp_document_highlight", {})
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 	group = "lsp_document_highlight",
-- 	buffer = bufnr,
-- 	callback = function()
-- 		vim.lsp.buf.document_highlight()
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("CursorMoved", {
-- 	group = "lsp_document_highlight",
-- 	buffer = bufnr,
-- 	callback = function()
-- 		vim.lsp.buf.clear_reference()
-- 	end,
-- })

--###########################################################################--
-- 							Neovide settings 								 --
--###########################################################################--
vim.cmd([[

	noremap <yy> "ay
	nmap <p> "ap

	set guifont=CodeNewRoman\ NF:h08
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
		color_9 = { "#7d5c34", "smart" }, -- Fallow brown
	},
})
