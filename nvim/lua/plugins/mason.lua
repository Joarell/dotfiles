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
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			require("sg").setup({})
			local dap_install = require("mason-nvim-dap")
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config
			-- local mason_lsp = require("mason-lspconfig")
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

			dap_install.setup({
				ensure_installed = {
					'stylua',
					'jq',
					'node-debug2-adapter',
					'codelldb',
					'bash-debug-adapter'
				},
				handlers = {},
			})

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
				"astro",
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				"eslint",
				"html",
				"jsonls",
				"nginx_language_server",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				-- "rustwind",
				"sqlls",
				"tsserver",
				"yamlls",
				"jdtls",
			}

			local servers = {
				tsserver = {
					-- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = 'all',
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = 'all',
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			}

			-- mason_lsp.setup({
			-- 	ensure_installed = SERVERS,
			-- 	automatic_installation = true,
			-- 	handlers = {
			-- 		settings = servers[server_name],
			-- 		filetypes = (servers[server_name] or {}).filetypes,
			-- 		function(server_name)
			-- 			require("lspconfig")[server_name].setup {}
			-- 		end
			-- 	}
			-- })


			-- require'lspconfig'.ngix_language_server.setup{}
			for _, lsp in pairs(SERVERS) do
				lspconfig[lsp].setup({
					dap = {
						adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
					},
					on_atttach = on_attach,
					capabilities = lsp_defaults.capabilities,
					single_file_support = true,
					flags = {
						debounce_text_changes = 50,
					},
				})
			end
		end,
		require 'lspconfig'.lua_ls.setup {
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
					client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT'
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								}
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							}
						}
					})

					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end
		}
	}
}
