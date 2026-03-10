--  ╭──────────────────────────────────────────────────────────╮
--  │ 		  --LSP and installer sever.                       │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			-- "folke/lazydev.nvim",
			"williamboman/nvim-lsp-installer",
			"williamboman/mason-lspconfig.nvim",
			"kabouzeid/nvim-lspinstall",
			"jay-babu/mason-nvim-dap.nvim",
			"jay-babu/mason-null-ls.nvim",
			"nielsdekker/detekt.nvim",
			-- "VonHeikemen/lsp-zero.nvim", branch = 'v4.x',
		},
		config = function()
			require("nvim-lsp-installer").setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "󰆤",
					},
					check_outdated_packages_on_open = true,
					border = "rounded",
				},
			})
			require("detekt").setup()
			require("mason-null-ls").setup({})
			-- require("lazydev").setup({})
			-- local lsp_zero = require("lsp-zero")
			local dap_install = require("mason-nvim-dap")
			local lspconfig = require("lspconfig")
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

			mason.setup({
				github = {
					download_url_template = "https://github.com/%s/releases/download/%s/%s",
				},
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "󰆤",
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

			local on_attach = function(client, bufnr)
				-- 1. Setup CursorHold to highlight symbol under cursor
				if client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd("CursorHold", {
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})

					-- 2. Setup CursorMoved to clear highlights
					vim.api.nvim_create_autocmd("CursorMoved", {
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end

			local servers = {
				astro = {},
				asm_lsp = {},
				-- asmfmt = {},
				-- ast_grep = {},
				bashls = {},
				biome = {},
				clangd = {},
				cssls = {},
				dockerls = {},
				docker_compose_language_service = {},
				-- eslint = {},
				gradle_ls = {},
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
							buildFlags = { "-tags=integration" },
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
								"-.nvim",
							},
						},
					},
				},
				-- grammarly = {},
				harper_ls = {
					["harper-ls"] = {
						userDictPath = "~/dotfiles/dict.txt",
					},
				},
				-- ['htmx-lsp'] = {},
				html = {
					filetypes = { "html", "twig", "hbs" },
				},
				-- dprint = {},
				jsonls = {},
				kotlin_language_server = {},
				kotlin_lsp = {},
				luau_lsp = {},
				lua_ls = {
					Lua = {
						completion = {
							autoRequire = true,
							callSnippet = "Replace",
							displayContext = 1,
						},
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						hint = {
							enable = true,
							arrayIndex = "Enable",
							setType = true,
						},
					},
				},
				lemminx = {},
				sqlls = {},
				vale_ls = {},
				pyright = {},
				pylsp = {},
				ts_ls = {
					-- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
					settings = {
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
						inlayHints = { enable = true },
					},
				},
				tinymist = {},
				typos_lsp = {},
				yamlls = {},
				jdtls = {},
				zls = {},
				zk = {},
			}

			mason_lsp.setup({
				automatic_enable = true,
				automatic_installation = true,
				ensure_installed = vim.tbl_keys(servers),
				on_attach = on_attach,
			})

			vim.g.rustaceanvim =
				{
					tools = {
						autoSetHints = true,
						hover_with_actions = true,
						inlay_hints = {
							only_current_line = false,
							show_parameter_hints = true,
							parameter_hints_prefix = "<-",
							other_hints_prefix = "->>",
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
						standalone = true,
						default_settings = {
							cmd = { "rusup", "run", "nightly", "rust_analyzer" },
						},
					},
					dap = {
						adapter = {
							type = "executable",
							command = "lldb-vscode",
							name = "rt_lldb",
						},
					},
				}, vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local bufnr = args.buf ---@type number
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client.supports_method("textDocument/inlayHint") then
							vim.lsp.inlay_hint.enable()
						end
					end,
				})
		end,
	},
}
