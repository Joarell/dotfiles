--###########################################################################--
--							Bindings SEttings 								 --
--###########################################################################--
local ls = require("luasnip")
vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Basic mapping
keymap("n", "<Leader>w", ":w!<CR>", opts)
keymap("n", "q", ":q!<CR>", opts)
keymap("n", "<Leader>s", ":so%<CR>", opts)
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<A-g>", ":G <cr>", opts)
keymap("n", "<Leader>gs", ":G status<cr>", opts)
keymap("n", "<A-g>c", ":G commit<cr>", opts)
keymap("n", "<Leader>gp", ":G push<cr>", opts)
keymap("n", "<Leader>gc", ":G commit<cr>", opts)
keymap("n", "<Leader>r", ":call vimspector#Restart()<cr>", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==g", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==g", opts)
keymap("v", "<PageUp>", ":m '<-2<CR>gv-gv", opts)
keymap("v", "<PageDown>", ":m '>+1<CR>gv-gv", opts)
keymap("n", "pv", "<C-w>v", opts)
keymap("n", "ps", "<C-w>s", opts)
keymap("n", "<Leader>ac", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gw", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<Leader>d", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "<Leader>af", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)

-- Luasnip bindings
keymap({ "i" }, "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)
keymap({ "i" }, "<C-j>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end, opts)

-- Plugins commnnds
keymap("i", "<S-Tab>", "<right>")
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("v", "<C-a>a", "<C-a>")
keymap({ "n", "v" }, "<Leader>/", ":CommentToggle<CR>", opts)
keymap("v", "<Leader>h", ":<C-H><C-H><C-H><C-H><C-H>HI +<CR>")
keymap("v", "<Leader>m", ":<C-H><C-H><C-H><C-H><C-H>HSHighlight ")
keymap("n", "<Leader><right>", ":HI ><CR>", opts)
keymap("n", "<Leader><left>", ":HI <<CR>", opts)
keymap("n", "<Leader>[", ":HI {<CR>", opts)
keymap("n", "<Leader>]", ":HI }<CR>", opts)
keymap("n", "<Leader>c", ":HI Clear<CR>", opts)
keymap("n", "<Leader>p", ":PackerUpdate<CR>", opts)
keymap("n", "<Leader>ps", ":PackerUpdate<CR>", opts)
keymap("n", "<Leader>b", ":ToggleBlameLine<CR>", opts)
keymap("n", "<C-w>|", ":WindowsMaximizeVertically<CR>", opts)
keymap("n", "<C-w>-", ":WindowsMaximizeHorizontally<CR>", opts)
keymap("n", "<Leader>hl", ":TSHighlightCapturesUnderCursor<CR>", opts)

-- "F" functions
keymap("n", "<F1>", ":RnvimrToggle<CR>", opts)
keymap("n", "<F2>", ":call vimspector#ClearLineBreakpoint()<CR>", opts)
keymap("n", "<F3>", ":WindowsMaximize<CR>", opts)
keymap("n", "<F4>", ":call vimspector#Reset()<CR>", opts)
keymap("n", "<F5>", ":call vimspector#Continue()<cr>", opts)
keymap("n", "<F6>", ":!gcc -wall -werror -wextra -g -D buffer_size= <c-r>% -o test <Up>", opts)
keymap("n", "<F7>", ":call vimspector#StepOver()<CR>", opts)
keymap("n", "<F8>", ":TagbarToggle<CR>", opts)
keymap("n", "<F9>", ":call vimspector#ToggleBreakpoint()<CR>", opts)
keymap("n", "<F10>", ":call vimspector#StepOver()<CR>", opts)
keymap("n", "<F11>", ":call vimspector#Continue()<CR>", opts)
keymap("n", "<F12>", ":lua vim.lsp.buf.format()<CR>", opts)
keymap("n", "vs", function()
	vim.diagnostic.config({ virtual_text = true })
end, opts)
keymap("n", "vo", function()
	vim.diagnostic.config({ virtual_text = false })
end, opts)

-- Folder function
keymap("n", "<Leader>f", function()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldcolumn = "6"
	print("This key binding folds all indentation lines to protect your code! Your Welcome! ;D")
end, { desc = "This key binding folds all indentation lines to protect your code! Your Welcome! ;D" })
keymap("n", "Q", function()
	print("Hello")
end, { desc = "Say hello" })
