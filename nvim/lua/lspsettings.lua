--###########################################################################--
--								 LSP settings								 --
--###########################################################################--
require("null_ls")
require("mason-null-ls").setup({
	automatic_setup = true,
})

local run = pcall(vim.cmd, 'MasonUpdate')
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
		check_outdated_packages_on_open = true,
		border = "rounded",
	},
	registries = {
		"lua:mason-registry.index",
		"github:mason-org/mason-registry",
	},
})

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
lsp_defaults.capabilities = vim.tbl_deep_extend(
	"force",
	lsp_defaults.capabilities,
	require("cmp_nvim_lsp").default_capabilities()
)
lspconfig.util.default_config = vim.tbl_deep_extend(
	"force",
	lspconfig.util.default_config,
	lsp_defaults
)


-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local navbuddy = require("nvim-navbuddy")
local completions = require("completions")
local on_attach = function(client, bufnr)
	if client.resolved_capabilities.completion then
		completions.on_attach(client, bufnr)
	end
	navbuddy.attach(client, bufnr)
end

local servers = {
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


require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

for _, lsp in pairs(servers) do
	lspconfig[lsp].setup({
		on_atttach = on_attach,
		capabilities = lsp_defaults.capabilities,
		-- capabilities = capabilities,
		single_file_support = true,
		flags = {
			debounce_text_changes = 50,
		},
	})
end
lspconfig.tailwindcss.setup {}
