--###########################################################################--
-- 							Settings		 								 --
--###########################################################################--

require("starter")
require("appearance")
require("nvim-ts-autotag").setup()
require("troublesettings")
require("lspsettings")
require("plugins")
require("neoscroll").setup()
require("nvim-tree").setup()
require("nvim_comment").setup()
require("telescope").load_extension("media_files")
require("bufferline").setup({})
require("vgit").setup()
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
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
	},
	highlight = { enable = true },
	sync_install = true,
	additional_vim_regex_highlighting = false,
})

--###########################################################################--
--							Format settings								     --
--###########################################################################--
local set = vim.opt

set.signcolumn = "yes"
set.guifont = "monospace:h17"
set.completeopt = { "menuone", "noselect" }
set.pumheight = 20
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
set.pumheight = 10
set.title = true
set.undofile = true
set.termguicolors = true
set.completeopt = { "menu", "menuone", "noselect" }
set.winblend = 10

--###########################################################################--
-- 							Bindings settings 								 --
--###########################################################################--

local builtin = require("telescope.builtin")
vim.keymap.set("n", "ff", builtin.find_files, {})
vim.keymap.set("n", "fg", builtin.live_grep, {})
vim.keymap.set("n", "fb", builtin.buffers, {})
vim.keymap.set("n", "fh", builtin.help_tags, {})

vim.keymap.set("n", "<Leader>w", ":w!<CR>")
vim.keymap.set("n", "<Leader>s", ":so%<CR>")
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "Q", function()
	print("Hello")
end, { desc = "Say hello" })
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<Leader>r", ":call vimspector#Restart()<cr>")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==g")
vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv")

vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==g")
vim.keymap.set("n", "<Leader>x", ":bw<CR>")
vim.keymap.set("n", "<Leader>/", ":CommentToggle<CR>")
vim.keymap.set("v", "<Leader>/", ":CommentToggle<CR>")
vim.keymap.set("n", "<F1>", ":RnvimrToggle<CR>")
vim.keymap.set("n", "<F12>", ":lua vim.lsp.buf.format()<CR>")
vim.keymap.set("v", "<Leader>h", ":<C-H><C-H><C-H><C-H><C-H>HI +<CR>")
vim.keymap.set("v", "<Leader>m", ":<C-H><C-H><C-H><C-H><C-H>HSHighlight ")
vim.keymap.set("n", "<Leader><right>", ":HI ><CR>")
vim.keymap.set("n", "<Leader><left>", ":HI <<CR>")
vim.keymap.set("n", "<Leader>[", ":HI {<CR>")
vim.keymap.set("n", "<Leader>]", ":HI }<CR>")
vim.keymap.set("n", "<Leader>c", ":HI Clear<CR>")
vim.keymap.set("n", "<Leader>p", ":PackerUpdate<CR>")
vim.keymap.set("n", "<Leader>b", ":ToggleBlameLine<CR>")

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

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require("colorizer").setup({
	"css",
	"javascript",
	html = {
		mode = "foreground",
	},
})

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require("colorizer").setup({
	"css",
	"javascript",
	html = { mode = "background" },
}, { mode = "foreground" })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require("colorizer").setup({
	"*", -- Highlight all files, but customize some others.
	css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
	html = { names = false }, -- Disable parsing "names" like Blue or Gray
})

-- Exclude some filetypes from highlighting by using `!`
require("colorizer").setup({
	"*", -- Highlight all files, but customize some others.
	"vim", -- Exclude vim from highlighting.
	-- Exclusion Only makes sense if '*' is specified!
})

require("nvim-treesitter.configs").setup({
	highlight = {
		-- ...
	},
	-- ...
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

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
