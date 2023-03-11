--###########################################################################--
--								 LSP settings								 --
--###########################################################################--
-- require("null_ls")
-- require("mason-null-ls").setup({
-- 	automatic_setup = true,
-- })
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		"cssls",
		"sqlls",
		-- "tailwindcss",
		"yamlls",
		"dockerls",
		"html",
		-- "eslint",
		-- "cmake",
		"lua_ls",
		"tsserver", --npm i -g typescript typescript-language-server
		-- 	"clangd",
		"bashls", --npm i -g bash-language-server
		"rust_analyzer",
		-- 	"pyright",
		"jsonls",
	},
	-- automatic_installation = true,
})

require("completions") -- ./complitions.lua
require("nvim-lsp-installer").setup({
	automatic_installation = true,
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	PATH = "prepend",
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	PATH = "prepend",
})

local signs = {
	Error = "",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

-- func
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Your custom attach funciont for nvim-lspconfig goes here.
local custom_nvim_lspconfig_attach = function(...)
end
require("nlua.lsp.nvim").setup(require("lspconfig"), {
	on_attach = custom_nvim_lspconfig_attach,
	-- Include globals you want to tell the LSP are real
	globals = {
		-- Colorbuddy
		"Color",
		"c",
		"Group",
		"g",
		"s",
	}
})

local lsp_defaults = {
	flags = {
		debounce_text_changes = 50,
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
	end,
}

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
	"force",
	lsp_defaults.capabilities,
	require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.util.default_config = vim.tbl_deep_extend(
	'force',
	lspconfig.util.default_config,
	lsp_defaults
)

local servers = {
	"yamlls",
	"sqlls",
	"cssls",
	"dockerls",
	-- "eslint",
	-- "cmake",
	"lua_ls",
	-- "tailwindcss",
	"tsserver", --npm i -g typescript typescript-language-server
	"clangd",
	"html", --npm i -g vscode-langservers-extracted
	-- "bashls", --npm i -g bash-language-server
	"rust_analyzer",
	-- "pyright",
	"jsonls",
}

for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		-- single_file_support = true,
		-- flags = {
		-- 	debounce_text_changes = 150,
		-- },
	})
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'sh',
	callback = function()
		vim.lsp.start({
			name = 'bash-language-server',
			cmd = { 'bash-language-server', 'start' },
		})
	end,
})
