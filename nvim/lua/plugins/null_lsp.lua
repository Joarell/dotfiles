
--  ╭──────────────────────────────────────────────────────────╮
--  │ 		--NULL LSP and settings                            │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"jose-elias-alvarez/null-ls.nvim" ,
		config = function ()
			local null_ls = require("null-ls")
			local null = null_ls.builtins

			null_ls.setup({
				sources = {
					null.formatting.stylua,
					-- null.formatting.eslint,
					null.formatting.codespell,
					-- null.formatting.shellharden,
					-- null.formatting.shfmt,
					-- null.formatting.djhtml,
					-- null.formatting.djlint,
					----------------------------------------
					-- null.diagnostics.eslint,
					-- null.diagnostics.clang_check,
					null.diagnostics.codespell,
					-- null.diagnostics.djlint,
					----------------------------------------
					null.completion.spell,
					----------------------------------------
					-- null.code_actions.eslint_d,
					-- null.code_actions.shellcheck,
					----------------------------------------
					-- null.hover.dictionary,
				},
				-- defaults = {
				-- 	border = "round",
				-- 	cmd = { "nvim" },
				-- 	debounce = 250,
				-- 	debug = false,
				-- 	default_timeout = 5000,
				-- 	diagnostic_config = {},
				-- 	diagnostics_format = "[#{c}] #{m} (#{s})",
				-- 	fallback_severity = vim.diagnostic.severity.ERROR,
				-- 	log_level = "warn",
				-- 	notify_format = "[null-ls] %s",
				-- 	on_attach = nil,
				-- 	on_init = nil,
				-- 	on_exit = nil,
				-- 	root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
				-- 	should_attach = nil,
				-- 	sources = nil,
				-- 	temp_dir = nil,
				-- 	update_in_insert = false,
				-- },
				-- should_attach = function(bufnr)
				-- 	return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
				-- end,
				linters = {
					command = "codespell",
					filetypes = {
						"bash",
						"javascript",
						"python",
						"html",
						"css",
						"rust"
					},
				},
				debug = true,
			})
		end
	}
}
