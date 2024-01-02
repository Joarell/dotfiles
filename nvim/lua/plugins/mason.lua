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
			"simrat39/rust-tools.nvim",
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
			-- local mason_registry = require("mason-registry")
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
			})

			lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
			lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = "additionalTextEdits"

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
			--
			-- 	local cfg = require('rustaceanvim.config')
			-- 	return {
			-- 		dap = {
			-- 			adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			-- 		},
			-- 	}
			-- end

			SERVERS = {
				"astro",
				"ast_grep",
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				-- "eslint",
				"gopls",
				"gopls",
				"html",
				"jsonls",
				"nginx_language_server",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"sqlls",
				"tsserver",
				"typos_lsp",
				"yamlls",
				"jdtls",
			}

			for _, lsp in pairs(SERVERS) do
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

			-- require("lspconfig")["rust_analyzer"].setup({
			-- 	on_atttach = function (client)
			-- 		require'completion'.on_atttach(client)
			-- 	end,
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		["rust-analyzer"] = {
			-- 			imports = {
			-- 				granularity = { group = "module" },
			-- 				prefix = "self",
			-- 			},
			-- 			cargo = {
			-- 				buildScripts = {
			-- 					enable = true,
			-- 				},
			-- 				allFeatures = true,
			-- 			},
			-- 			procMacro = {
			-- 				enable = true
			-- 			},
			-- 		}
			-- 	}
			-- })

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
			-- lspconfig["rust_analyzer"].setup({
			lspconfig.rust_analyzer.setup({
				on_attach = function(client)
					require("completion").on_attach(client)
				end,
				capabilities = capabilities,
				filetypes = { "rust" },
				root_dir = lspconfig.util.root_pattern("Cargo.toml"),
				cmd = {
					"rustup", "run", "stable", "rust-analyzer",
				},
				settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
							allFeatures = true,
						},
						procMacro = {
							enable = true,
						},
					},
					function()
						local opts = {
							executor = require("rust-tools.executors").termopen,
							runnables = {
								use_telescope = true,
							},
							inlay_hints = {
								auto = true,
								show_parameter_hints = false,
								parameter_hints_prefix = "",
								other_hints_prefix = "",
							},
						}
						require("rust-tools").setup(opts)
					end,
				},
			})

			-- local opts = {
			-- 	executor = require("rust-tools.executors").termopen,
			-- 	runnables = {
			-- 		use_telescope = true,
			-- 	},
			-- 	inlay_hints = {
			-- 		auto = true,
			-- 		show_paramater_hints = false,
			-- 		parameter_hints_prefix = "",
			-- 		other_hints_prefix = "",
			-- 	},
			-- }
			-- require("rust-tools").setup(opts)

			mason_lsp.setup({
				automatic_installation = true,
				-- ensure_installed = SERVERS,
			})

			mason_lsp.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
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
