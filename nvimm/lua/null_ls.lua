--###########################################################################--
--						Diagnostics Settings								 --
--###########################################################################--
local null_ls = require("null-ls")
local null = null_ls.builtins

null_ls.setup({
	sources = {
		null.formatting.stylua,
		null.formatting.eslint,
		null.formatting.codespell,
		null.formatting.shellharden,
		null.formatting.shfmt,
		null.formatting.djhtml,
		null.formatting.djlint,
		----------------------------------------
		-- null.diagnostics.eslint,
		null.diagnostics.clang_check,
		null.diagnostics.codespell,
		null.diagnostics.djlint,
		----------------------------------------
		null.completion.spell,
		null.completion.vsnip,
		----------------------------------------
		null.code_actions.eslint_d,
		null.code_actions.shellcheck,
		----------------------------------------
		null.hover.dictionary,
	},
	defaults = {
		cmd = { "nvim" },
		debounce = 250,
		debug = false,
		default_timeout = 5000,
		diagnostic_config = nil,
		diagnostics_format = "#{m}",
		fallback_severity = vim.diagnostic.severity.ERROR,
		log_level = "warn",
		notify_format = "[null-ls] %s",
		on_attach = nil,
		on_init = nil,
		on_exit = nil,
		root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
		sources = nil,
		update_in_insert = false,
	},
	should_attach = function(bufnr)
		return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
	end,
	linters = {
		command = "codespell",
		filetypes = { "bash", "javascript", "python", "html", "css", "rust" },
	},
	debug = true,
})

--  ╭──────────────────────────────────────────────────╮
--  │ -- register any number of sources simultaneously │
--  ╰──────────────────────────────────────────────────╯
-- null_ls.setup({ sources = sources })
-- local helpers = require("null-ls.helpers")
-- local nodejs = {
-- 	method = null_ls.methods.DIAGNOSTICS,
-- 	filetypes = {
-- 		"javascript",
-- 		"typescript",
-- 	},
-- 	-- null_ls.generator creates an async source
-- 	-- that spawns the command with the given arguments and options
-- 	generator = null_ls.generator({
-- 		command = "eslint_d",
-- 		args = { "--stdin" },
-- 		to_stdin = true,
-- 		from_stderr = true,
-- 		-- choose an output format (raw, json, or line)
-- 		format = "line",
-- 		check_exit_code = function(code, stderr)
-- 			local success = code <= 1
--
-- 			if not success then
-- 				-- can be noisy for things that run often (e.g. diagnostics), but can
-- 				-- be useful for things that run on demand (e.g. formatting)
-- 				print(stderr)
-- 			end
--
-- 			return success
-- 		end,
-- 		-- use helpers to parse the output from string matchers,
-- 		-- or parse it manually with a function
-- 		on_output = helpers.diagnostics.from_patterns({
-- 			{
-- 				pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
-- 				groups = { "row", "col", "message" },
-- 			},
-- 			{
-- 				pattern = [[:(%d+) [%w-/]+ (.*)]],
-- 				groups = { "row", "message" },
-- 			},
-- 		}),
-- 	}),
-- }

-- null_ls.register(nodejs)
