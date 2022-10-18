
--###########################################################################--
--								 LSP settings								 --
--###########################################################################--
require('complitions')
require('null_ls')
require('mason-lspconfig').setup()

local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}


for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


local lsp_defaults = {
	flags = {
		debounce_text_changes = 50,
	},
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
	end
}

local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_deep_extend(
	'force',
	lspconfig.util.default_config,
	lsp_defaults
)

local servers = {
	'sumneko_lua',
	'tsserver', --npm i -g typescript typescript-language-server
	'clangd',
	'html', --npm i -g vscode-langservers-extracted
	'bashls', --npm i -g bash-language-server
	'rust_analyzer',
	'pyright',
}

for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {}
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'LspAttached',
	desc = 'LSP actions',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		-- Displays hover information about the symbol under the cursor
		bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
		-- Jump to the definition
		bufmap('n', '<Leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
		-- Lists all the implementations for the symbol under the cursos
		bufmap('n', '<Leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>')
		-- Jumps to the definition of the type symbol
		bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
		-- Lists all the references
		bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
		-- Display a function's signature information
		bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
		-- Move to the previous diagnostic
		bufmap('n', '[d', '<cmd>lua vim.lsp.buf.diagnostic.goto_prev()<CR>')
		-- Move to the next diagnostic
		bufmap('n', ']d', '<cmd>lua vim.lsp.buf.diagnostic.goto_next()<CR>')
	end
})
