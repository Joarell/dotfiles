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
			"jay-babu/mason-null-ls.nvim",
			-- "simrat39/rust-tools.nvim",
		},
		config = function()
			require("mason-null-ls").setup({})
			require("sg").setup({})
			local dap_install = require("mason-nvim-dap")
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config
			local mason_lsp = require("mason-lspconfig")
			local mason = require("mason")
			local completions = require("cmp")
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

			-- local on_attach = function(client, bufnr)
			-- 	if client.resolved_capabilities.completion then
			-- 		completions.on_attach(client, bufnr)
			-- 	end
			-- end
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desck = desc })
				end
			end

			dap_install.setup({
				ensure_installed = {
					"stylua",
					"jq",
					"node-debug2-adapter",
					"codelldb",
					"bash-debug-adapter",
				},
				handlers = {},
			})

			mason.setup({
				github = {
					download_url_template = "https://github.com/%s/releases/download/%s/%s",
				},
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
				providers = {
					"mason.providers.registry-api",
					"mason.providers.client",
				},
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lsp_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lsp_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities(capabilities)
			)
			lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- vim.g.rustaceanvim = function()
			-- 	-- Update this path
			-- 	local codelldb = mason_registry.get_package("codelldb")
			-- 	local extension_path = codelldb:get_install_path() .. "/extension/"
			-- 	local codelldb_path = extension_path .. "adapter/codelldb"
			-- 	local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
			-- 	local this_os = vim.uv.os_uname().sysname;
			--
			-- 	-- The path is different on Windows
			-- 	if this_os:find "Windows" then
			-- 		codelldb_path = extension_path .. "adapter\\codelldb.exe"
			-- 		liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
			-- 	else
			-- 		-- The liblldb extension is .so for Linux and .dylib for MacOS
			-- 		liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
			-- 	end

			local servers = {
				astro = {},
				ast_grep = {},
				bashls = {},
				clangd = {},
				cssls = {},
				dockerls = {},
				-- "eslint",
				gopls = {},
				html = {
					filetypes = { 'html', 'twig', 'hbs' }
				},
				jsonls = {},
				nginx_language_server = {},
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						hint = { enable = true },
					},
				},
				pyright = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							imports = {
								granularity = {
									group = "module",
								},
								prefix = "self",
							},
							cargo = {
								allFeatures = true,
								buildScripts = true,
							},
							procMacro = { enable = true },
							inlayHints = {
								enable = true
							}
						},
					}
				},
				sqlls = {},
				tsserver = {
					-- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all",
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
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
				typos_lsp = {},
				yamlls = {},
				jdtls = {},
			}

			-- for _, lsp in pairs(servers) do
			-- 	lspconfig[lsp].setup({
			-- 		on_atttach = on_attach,
			-- 		capabilities = lsp_defaults.capabilities,
			-- 		-- capabilities = capabilities,
			-- 		single_file_support = true,
			-- 		flags = {
			-- 			debounce_text_changes = 50,
			-- 		},
			-- 		hint = { enable = true },
			-- 	})
			-- end

			-- lspconfig.rust_analyzer.setup({
			-- 	on_attach = function(client)
			-- 		require("completion").on_attach(client)
			-- 	end,
			-- 	capabilities = capabilities,
			-- 	filetypes = { "rust" },
			-- 	root_dir = lspconfig.util.root_pattern("Cargo.toml"),
			-- 	cmd = {
			-- 		"rustup",
			-- 		"run",
			-- 		"stable",
			-- 		"rust-analyzer",
			-- 	},
			-- 	settings = {
			-- 		["rust-analyzer"] = {
			-- 			imports = {
			-- 				granularity = {
			-- 					group = "module",
			-- 				},
			-- 				prefix = "self",
			-- 			},
			-- 			cargo = {
			-- 				buildScripts = {
			-- 					enable = true,
			-- 				},
			-- 				allFeatures = true,
			-- 			},
			-- 			procMacro = {
			-- 				enable = true,
			-- 			},
			-- 		},
			-- 	},
			-- })

			mason_lsp.setup({
				automatic_installation = true,
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lsp.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,

		require("lspconfig").lua_ls.setup({
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								},
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							},
						},
					})

					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end,
		}),
	},
}
