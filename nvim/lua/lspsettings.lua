--###########################################################################--
--								 LSP settings								 --
--###########################################################################--
require("null_ls")
require("nvim-lsp-installer").setup({})
require("mason-null-ls").setup({
	automatic_setup = true,
})
require("mason-lspconfig").setup({
	ensure_installed = SERVERS,
	automatic_installation = true,
})

local run = pcall(vim.cmd, 'MasonUpdate')

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local completions = require("completions") -- ./complitions.lua
local signs = {
	Error = "",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Your custom attach funciont for nvim-lspconfig goes here.
local custom_nvim_lspconfig_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- local lsp_def = {
-- 	flags = {
-- 		debounce_text_changes = 50,
-- 	},
-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
-- 	on_attach = function(client, bufnr)
-- 		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
-- 	end,
-- }

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
--
lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

SERVERS = {
	"bashls",
	"clangd",
	"cssls",
	"dockerls",
	"html",
	"jsonls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"sqlls",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(client, bufnr)
	if client.resolved_capabilities.completion then
		completions.on_attach(client, bufnr)
	end
end

for _, lsp in pairs(SERVERS) do
	lspconfig[lsp].setup({
		on_atttach = on_attach,
		capabilities = capabilities,
		single_file_support = true,
		flags = {
			debounce_text_changes = 50,
		},
	})
end
