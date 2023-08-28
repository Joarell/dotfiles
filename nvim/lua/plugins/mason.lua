
--  ╭──────────────────────────────────────────────────────────╮
--  │ 		--LSP and installer sever.                         │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/nvim-lsp-installer",
			"williamboman/mason-lspconfig.nvim",
			"kabouzeid/nvim-lspinstall",
			-- "jayp0521/mason-null-ls.nvim",
		},
		config = function ()
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config
			local mason_lsp = require("mason-lspconfig")
			local mason = require("mason")
			local completions = require("cmp")
			local mason_registry = require("mason-registry")
			local signs = {
				Error = "",
				Warn = " ",
				Hint = " ",
				Info = " ",
				Break = "",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local on_attach = function(client, bufnr)
				if client.resolved_capabilities.completion then
					completions.on_attach(client, bufnr)
				end
			end

			mason.setup({
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
			local codelldb = mason_registry.get_package('codelldb')
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

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
				"tsserver",
				"yamlls",
				"jdtls",
			}

			mason_lsp.setup({
				ensure_installed = SERVERS,
				automatic_installation = true,
			})

			for _, lsp in pairs(SERVERS) do
				lspconfig[lsp].setup({
					dap = {
						adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
					},
					on_atttach = on_attach,
					capabilities = lsp_defaults.capabilities,
					-- capabilities = capabilities,
					single_file_support = true,
					flags = {
						debounce_text_changes = 50,
					},
				})
			end
		end
	}
}
