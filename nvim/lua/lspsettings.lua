--###########################################################################--
--								 LSP settings								 --
--###########################################################################--
-- require("mason-null-ls").setup({
-- 	automatic_setup = true,
-- })

local run = pcall(vim.cmd, "MasonUpdate")
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
lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.tailwindcss.setup({})
