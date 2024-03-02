--  ╭──────────────────────────────────────────────────────────╮
--  │ 		--NULL LSP and settings                            │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local null = null_ls.builtins

			null_ls.setup({
				sources = {
					null.formatting.stylua,
					null.formatting.prettierd,
					null.formatting.prettier.with({
						filetypes = {
							"html",
							"css",
							"json",
							"yaml",
							"markdown",
							"javascript",
							"js",
							"rust",
							"lua",
						},
					}),
					-- null.formatting.eslint,
					-- null.formatting.rust_analyzer,
					null.formatting.codespell,
					null.formatting.shellharden,
					-- null.formatting.shfmt,
					null.formatting.djhtml,
					-- null.formatting.djlint,
					null.formatting.sqlfmt,
					null.formatting.ktlint,
					null.formatting.sql_formatter,
					null.formatting.asmfmt,
					----------------------------------------
					-- null.diagnostics.eslint,
					null.diagnostics.selene,
					null.diagnostics.trivy,
					-- null.diagnostics.clang_check,
					-- null.diagnostics.codespell,
					-- null.diagnostics.ltex,
					null.diagnostics.ktlint,
					null.diagnostics.markdownlint,
					null.diagnostics.write_good,
					-- null.diagnostics.cpplint,
					-- null.diagnostics.djlint,
					----------------------------------------
					-- null.completion.spell,
					----------------------------------------
					-- null.code_actions.eslint_d,
					-- null.code_actions.shellcheck,
					-- null.code_actions.ltrs,
					----------------------------------------
					null.hover.dictionary,
				},
				defaults = {
					border = "round",
					cmd = { "nvim" },
					debounce = 250,
					debug = false,
					autostart = true,
					default_timeout = 5000,
					diagnostic_config = {},
					diagnostics_format = "[#{c}] #{m} (#{s})",
					fallback_severity = vim.diagnostic.severity.ERROR,
					log_level = "warn",
					notify_format = "[null-ls] %s",
					on_attach = nil,
					on_init = nil,
					on_exit = nil,
					root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git", "Cargo.toml"),
					should_attach = nil,
					sources = nil,
					temp_dir = nil,
					update_in_insert = false,
				},
				should_attach = function(bufnr)
					return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
				end,
				linters = {
					command = "codespell",
					filetypes = {
						"bash",
						"javascript",
						"python",
						"html",
						"css",
						"rust",
					},
				},
				debug = true,
			})
		end,
	},
}
