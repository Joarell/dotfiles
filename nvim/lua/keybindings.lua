--                             ╭───────────────────╮
--                             │ Bindings Settings │
--                             ╰───────────────────╯
local ls = require("luasnip")
vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

--[[************************************************************************]]--
--[[                             Basic mappings                             ]]--
--[[************************************************************************]]--
keymap("n", "<Leader>w", ":w!<CR>", opts)
keymap("n", "E", ":q!<CR>", opts)
keymap("n", "<Leader>s", ":so%<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<A-g>", ":G <cr>", opts)
keymap("n", "<A-g>c", ":G commit<cr>", opts)
keymap("n", "<A-P>", ":G push origin HEAD<cr>", opts)
keymap("n", "<A-C>", ":G commit<cr>", opts)
keymap("n", "<Leader>gs", ":Gvdiffsplit HEAD~1<cr>", opts)
keymap("n", "<Leader>gsp", ":Gsplit HEAD~1<cr>", opts)
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
keymap("n", "<C-c>a", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gs", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<Leader>d", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "<Leader>af", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<A-T>", function ()
	vim.lsp.inlay_hint(0, nil)
end, { desc = "Toggle Inlay Hints" }, opts)
keymap({ "i", "v" }, "<C-c>", "<Esc>", opts)
keymap("n", "cn", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("v", "<C-s>", ":SnipRun<cr>", opts)
keymap("n", "vu", function()
	vim.diagnostic.config({ virtual_text = false })
end, opts)
keymap("n", "vs", function()
	vim.diagnostic.config({ virtual_text = true })
end, opts)

--[[************************************************************************]]--
--[[                           Luasnip bindings:                            ]]--
--[[************************************************************************]]--
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

--[[************************************************************************]]--
--[[                            Plugins commands                            ]]--
--[[************************************************************************]]--
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
keymap("n", "<Leader>c", ":HSRmHighlight<CR>", opts)
keymap("n", "<Leader>l", ":Lazy<CR>", opts)
keymap("n", "<Leader>b", ":ToggleBlameLine<CR>", opts)
keymap("n", "<C-w>-", ":WindowsMaximizeVertically<CR>", opts)
keymap("n", "<C-w>|", ":WindowsMaximizeHorizontally<CR>", opts)
keymap("n", "<Leader>hl", ":TSHighlightCapturesUnderCursor<CR>", opts)
keymap({ "n", "v" }, "<A-t>", ":Pantran<CR>", opts)
keymap({ "n", "v" }, "<Leader>x", ":RegexplainerShowPopup<CR>", opts)
keymap({ "n", "v" }, "<Leader>xh", ":RegexplainerHide<CR>", opts)
keymap({ "n", "i" }, "<Leader>ac", ':lua require("nvim-comment-frame").add_comment()<CR>', opts)
keymap({ "n", "i" }, "<Leader>C", ':lua require("nvim-comment-frame").add_multiline_comment()<CR>', opts)
keymap({ "n", "v" }, "cm", ":CBacbox<CR>", opts) -- left alignment adaptable
keymap({ "n", "v" }, "<A-A>", ":CBlcbox<CR>", opts) -- center alignment
keymap({ "n", "v" }, "<A-B>", ":CBalbox<CR>", opts)
-- keymap("n", "TL", ":TwilightEnable<CR>", opts)
-- keymap("n", "TO", ":TwilightDisable<CR>", opts)
keymap("n", "<Leader>da", ':DiffviewOpen<CR>', opts)
keymap("n", "<Leader>do", ':DiffviewClose<CR>', opts)
keymap("n", "<A-g>", ":VGit project_diff_preview<cr>", opts)
keymap("n", "<A-D>", ':VGit buffer_diff_preview<CR>', opts)
keymap("n", "<Leader>n", ':Navbuddy<CR>', opts)

keymap("n", "<Leader>h", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
keymap("n", "<Leader>a", ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<Leader>fe", ':lua require("harpoon.ui").nav_file()', opts)

keymap("n", "<Leader>du", 'DBUI<CR>', opts)

--[[************************************************************************]]--
--[[                             "F" functions:                             ]]--
--[[************************************************************************]]--
keymap("n", "<F1>", ":RnvimrToggle<CR>", opts)
keymap("n", "<F2>", ":DapTerminate<cr>", opts)
keymap("n", "<F3>", ":WindowsMaximize<CR>", opts)
keymap("n", "<F4>", ":lua require('dap').restart()<CR>", opts)
keymap("n", "<F5>", ":DapContinue<CR> and vim.cmd('1')<CR>", opts)
keymap("n", "<F6>", ":lua require('dapui').float_element()<CR>", opts)
-- keymap("n", "<F6>", ":!gcc -wall -werror -wextra -g -D buffer_size= <c-r>% -o test <Up>", opts)
-- keymap("n", "<F8>", ":DapContinue<CR>", opts)
keymap("n", "<F8>", ":G<CR>", opts)
keymap("n", "<F9>", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<F10>", ":DapStepInto<CR>", opts)
keymap("n", "<F11>", ":DapContinue<CR>", opts)
keymap("n", "<F12>", ":lua vim.lsp.buf.format()<CR>", opts)


--[[************************************************************************]]--
--[[                            Folder function:                            ]]--
--[[************************************************************************]]--

keymap("n", "<Leader>f", function()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldcolumn = "8"
	print("This key binding folds all indentation lines to protect your code! Your Welcome!😎")
end, { desc = "This key binding folds all indentation lines to protect your code! Your Welcome! 😎" })
