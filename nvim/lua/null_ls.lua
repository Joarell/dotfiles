--###########################################################################--
--						Diagnostics Settings								 --
--###########################################################################--
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.eslint,
		null_ls.builtins.formatting.codespell,
		-------------------------------------
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.clang_check,
		null_ls.builtins.diagnostics.codespell,
		null_ls.builtins.diagnostics.cspell.with {
			filetypes = { 
				"javascript",
				"python",
				"html",
				"css",
				"rust",
				"lua",
				"typescript",
				"bash",
			},
		},
		-------------------------------------
		null_ls.builtins.completion.spell,
		null_ls.builtins.completion.vsnip,
		-------------------------------------
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.code_actions.cspell.with {
			filetypes = { 
				"javascript",
				"python",
				"html",
				"css",
				"rust",
				"lua",
				"typescript",
				"bash",
			},
		},
		-------------------------------------
		-- b.hover.dictionary,
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
		filetypes = { "javascript", "python", "html", "css", "rust" },
	},
})

-- register any number of sources simultaneously
null_ls.setup({ sources = sources })

local nodejs = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = {
		"javascript",
		"typescript",
	},
	-- null_ls.generator creates an async source
	-- that spawns the command with the given arguments and options
	generator = null_ls.generator({
		command = "eslint_d",
		args = { "--stdin" },
		to_stdin = true,
		from_stderr = true,
		-- choose an output format (raw, json, or line)
		format = "line",
		check_exit_code = function(code, stderr)
			local success = code <= 1

			if not success then
				-- can be noisy for things that run often (e.g. diagnostics), but can
				-- be useful for things that run on demand (e.g. formatting)
				print(stderr)
			end

			return success
		end,
		-- use helpers to parse the output from string matchers,
		-- or parse it manually with a function
		on_output = helpers.diagnostics.from_patterns({
			{
				pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
				groups = { "row", "col", "message" },
			},
			{
				pattern = [[:(%d+) [%w-/]+ (.*)]],
				groups = { "row", "message" },
			},
		}),
	}),
}

null_ls.register(nodejs)
