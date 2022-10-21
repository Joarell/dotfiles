--###########################################################################--
-- 							Bindings settings 								 --
--###########################################################################--
vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

keymap("n", "<Leader>w", ":w!<CR>", opts)
keymap("n", "q", ":wq!<CR>", opts)
keymap("n", "<Leader>s", ":so%<CR>", opts)
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)

-- keymap("n", "<Leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<Leader>r", ":call vimspector#Restart()<cr>", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==g", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==g", opts)
keymap("n", "<Leader>x", ":bw<CR>", opts)
keymap("v", "K", ":m '<-2<CR>gv-gv", opts)
keymap("v", "J", ":m '>+1<CR>gv-gv", opts)
keymap("n", "vv", "<C-w>v", opts)
keymap("n", "ss", "<C-w>s", opts)
keymap("n", "<Leader>ac", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gw", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "<Leader>af", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)

-- Plugins commnnds
keymap("n", "<Leader>/", ":CommentToggle<CR>")
keymap("v", "<Leader>/", ":CommentToggle<CR>")
keymap("v", "<Leader>h", ":<C-H><C-H><C-H><C-H><C-H>HI +<CR>")
keymap("v", "<Leader>m", ":<C-H><C-H><C-H><C-H><C-H>HSHighlight ")
keymap("n", "<Leader><right>", ":HI ><CR>")
keymap("n", "<Leader><left>", ":HI <<CR>")
keymap("n", "<Leader>[", ":HI {<CR>")
keymap("n", "<Leader>]", ":HI }<CR>")
keymap("n", "<Leader>c", ":HI Clear<CR>")
keymap("n", "<Leader>p", ":PackerUpdate<CR>")
keymap("n", "<Leader>b", ":ToggleBlameLine<CR>")
keymap("n", "<C-w>|", ":WindowsMaximizeVertically<CR>", opts)
keymap("n", "<C-w>-", ":WindowsMaximizeHorizontally<CR>", opts)
keymap("n", "<Leader>hl", ":TSHighlightCapturesUnderCursor<CR>", opts)

-- "F" functions
keymap("n", "<F1>", ":RnvimrToggle<CR>")
keymap("n", "<F2>", ":call vimspector#ClearLineBreakpoint()<CR>")
keymap("n", "<F3>", ":WindowsMaximize<CR>", opts)
keymap("n", "<F4>", ":call vimspector#Reset()<CR>")
keymap("n", "<F5>", ":call vimspector#Continue()<cr>")
keymap("n", "<F6>", ":!gcc -wall -werror -wextra -g -D buffer_size= <c-r>% -o test <Up>")
keymap("n", "<F7>", ":call vimspector#StepOver()<CR>")
keymap("n", "<F8>", ":TagbarToggle<CR>")
keymap("n", "<F9>", ":call vimspector#ToggleBreakpoint()<CR>")
keymap("n", "<F10>", ":call vimspector#StepOver()<CR>")
keymap("n", "<F11>", ":call vimspector#Continue()<CR>")
keymap("n", "<F12>", ":lua vim.lsp.buf.format()<CR>")
-- Folder function
keymap("n", "<Leader>f", function()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	print("This key binding folds all indentation lines to protect your code! Your Welcome! ;D")
end, { desc = "This key binding folds all indentation lines to protect your code! Your Welcome! ;D" })
keymap("n", "Q", function()
	print("Hello")
end, { desc = "Say hello" })

-- Telescope mappins
local builtin = require("telescope.builtin")
require("telescope").load_extension("media_files")
require("telescope").setup({
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
})
require("telescope").setup({
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
})

keymap("n", "ff", builtin.find_files, opts)
keymap("n", "fg", builtin.live_grep, opts)
keymap("n", "fb", builtin.buffers, opts)
keymap("n", "fh", builtin.help_tags, opts)
keymap("n", "tt", ":Telescope<CR>", opts)
keymap("n", "tk", ":Telescope keymaps<CR>", opts)
keymap("n", "tm", ":Telescope media_files<CR>", opts)
