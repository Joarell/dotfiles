--  ╭──────────────────────────────────────────────────────────╮
--  │ 		--LSP and installer sever.                         │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"folke/lazydev.nvim",
			"williamboman/nvim-lsp-installer",
			"williamboman/mason-lspconfig.nvim",
			"kabouzeid/nvim-lspinstall",
			"jay-babu/mason-nvim-dap.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			require("nvim-lsp-installer").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					check_outdated_packages_on_open = true,
					border = "rounded",
				},
			})

			require("mason-null-ls").setup({})
			-- require("sg").setup({})
			require("lazydev").setup({})
			local dap_install = require("mason-nvim-dap")
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config
			local mason_lsp = require("mason-lspconfig")
			local mason = require("mason")
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
				-- local navbuddy = require("nvim-navbuddy")
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desck = desc })
				end
				-- vim.lsp.completion.enable(true, client, 0, { autotrigger = true })

				if vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable()
				end
			end

			-- local codelldb = mason_registry.get_package("codelldb")
			-- local extension_path = codelldb:get_install_path() .. "/extension/"
			-- local codelldb_path = extension_path .. "adapter/codelldb"
			-- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

			-- dap_install.setup({
			-- 	ensure_installed = {
			-- 		"stylua",
			-- 		"jq",
			-- 		"node-debug2-adapter",
			-- 		"codelldb",
			-- 		"bash-debug-adapter",
			-- 	},
			-- 	handlers = {},
			-- })

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

			local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "swift", "objective-c", "objective-cpp" },
				callback = function()
					local root_dir = vim.fs.dirname(vim.fs.find({
						"Package.swift",
						".git",
					}, { upward = true })[1])
					local client = vim.lsp.start({
						filetypes = { "swift", "objective-c", "objective-cpp" },
						autostart = true,
						name = "sourcekit-lsp",
						cmd = { "/usr/bin/sourcekit-lsp" },
						root_dir = root_dir,
					})
					vim.lsp.buf_attach_client(0, client)
				end,
				group = swift_lsp,
			})

			local servers = {
				astro = {},
				asm_lsp = {},
				-- asmfmt = {},
				-- ast_grep = {},
				bashls = {},
				clangd = {},
				cssls = {},
				dockerls = {},
				docker_compose_language_service = {},
				-- "eslint",
				kotlin_language_server = {},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								fieldalignment = true,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							experimentalPostfixCompletion = true,
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								useParameterNames = true,
								rangeVariableTypes = true,
							},
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							buildFlags = {"-tags=integration"},
							completeUnimported = true,
							semanticTokens = true,
							gofumpt = true,
							staticcheck = true,
							usePlaceholders = true,
							directoryFilters = {
								"-.git",
								"-.vscode",
								"-.idea",
								"-.vscode-test",
								"-node_modules",
								"-.nvim"
							},
						},
					},
				},
				-- ['htmx-lsp'] = {},
				html = {
					filetypes = { "html", "twig", "hbs" },
				},
				-- dprint = {},
				jsonls = {},
				luau_lsp = {},
				lua_ls = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						hint = { enable = true },
					},
				},
				marksman = {},
				nginx_language_server = {
					cmd = {"nginx-language-server"},
					filetypes = {"nginx"}
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
				typst_lsp = {},
				typos_lsp = {},
				yamlls = {},
				jdtls = {},
				zls =  {}
			}

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

			vim.g.rustaceanvim = {
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					inlay_hints = {
						only_current_line = false,
						show_parameter_hints = true,
						parameter_hints_prefix = "",
						other_hints_prefix = "",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
						highlight = "Comment",
					},
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					on_attach = function (client, bufnr)
						if vim.lsp.inlay_hint then
							vim.lsp.inlay_hint.enable(bufnr, true)
						end
					end,
					standalone = true,
					default_settings = {
						cmd = {'rusup', 'run', 'nightly', 'rust_analyzer'},
						["rust-analyzer"] = {
							assist = {
								importEnforceGranualrity = true,
								importPrefix = "crate",
							},
							diagnostics = { enable = true },
							inlayHints = {
								lifetimeElisionHints = {
									enable = true,
									useParameterNames = true,
								},
							},
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
							check = {
								command = "clippy",
							},
							standalone = false,
							procMacro = { enable = true },
						},
					}
				},
				dap = {
					adapter = {
						type = "executable",
						command = "lldb-vscode",
						name = "rt_lldb",
					},
				}
			}
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
