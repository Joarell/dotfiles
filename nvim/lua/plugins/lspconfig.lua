function setup_ghostty_lsp()
    -- Only activate ghostty-lsp when editing the ghostty config
    if vim.fn.expand("%:p") == vim.fs.normalize("~/.config/ghostty/config") then
        vim.lsp.start({
            name = "ghostty-lsp",
            cmd = { "ghostty-lsp" },
            root_dir = vim.fs.normalize("~/.config/ghostty")
        })
    end
end

vim.api.nvim_create_autocmd("BufRead", { pattern = "*", callback = setup_ghostty_lsp })
return {
	vim.lsp.config('*', {
		capabilities = {
			textDocument = {
				semanticTokens = {
					multilineTokenSupport = true,
				}
			}
		}
	}),

	vim.lsp.config("ts_ls", {
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
		},
	}),

	vim.lsp.config("lua_ls", {
		settings = {
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
					arrayIndex = 'Enable',
					setType = true,
				},
			},
		}
	}),

	vim.lsp.config("gopls", {
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
	}),

	vim.lsp.enable('rustowlsp'),
	vim.lsp.enable('rustowl'),
	vim.lsp.config('rustowl', {
		settings = {
			auto_enable = true,
			idle_time = 300,
			highlight_style = 'underline',
			colors = {
				colors = {
					lifetime = '#50fa7b',   -- Dracula green
					imm_borrow = '#8be9fd', -- Dracula cyan
					mut_borrow = '#ff79c6', -- Dracula pink
					move = '#f1fa8c',       -- Dracula yellow
					call = '#ffb86c',       -- Dracula orange
					outlive = '#ff5555',    -- Dracula red
				},
			},
			client = {
				on_attach = function(_, buffer)
					print('attached', buffer)
					vim.keymap.set('n', '<leader>o', function()
						require('rustowl').toggle(buffer)
					end, { buffer = buffer, desc = 'Toggle RustOwl' })

					vim.keymap.set('n', '<leader>re', function()
						require('rustowl').enable(buffer)
					end, { buffer = buffer, desc = 'Enable RustOwl' })

					vim.keymap.set('n', '<leader>rd', function()
						require('rustowl').disable(buffer)
					end, { buffer = buffer, desc = 'Disable RustOwl' })
				end
			},
		},
	}),

	vim.lsp.config('harper_ls', {
		settings = {
			userDictPath = "~/dotfiles/dict.txt"
		}
		-- ["harper-ls"] = {
		-- 	userDictPath = "~/dotfiles/dict.txt"
		-- }
	}),

	vim.lsp.config('html', {
		filetypes = { "html", "twig", "hbs" },
	}),

	vim.lsp.config("rust-analyzer", {
		settings = {
			["rust-analyzer"] = {
				assist = {
					importEnforceGranualrity = true,
					importPrefix = "create",
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
				checkOnSave = true,
				standalone = false,
				procMacro = {
					enable = true,
					ignored = {
						["async-trait"] = { "async_trait" },
						["napi-derive"] = { "napi" },
						["async-recursion"] = { "async_recursion" },
					},
				},
			},
		},
	}),
}
