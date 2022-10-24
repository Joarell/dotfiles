require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
})

require("nvim-treesitter.configs").setup({ -- Here is all languages suportted. Feel free to update it.
	ensure_installed = {
		"bash",
		"c",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"tsx",
		"css",
		"html",
		"rust",
		"java",
		"yaml",
		"markdown",
		"kotlin",
		"yaml",
		"rust",
		"cmake",
		"vim",
		"regex",
	},
	sync_install = true,
	additional_vim_regex_highlighting = true,
	indent = { enable = true },
	highlight = {
		enable = true, -- false will disble the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		enable = true,
		-- disable = {"jsx", "cpp"}, list of languages you want to disable the plugin for
		extended_mode = ture, -- Also higlight non-bracket delimiters.
		max_file_lines = nil, -- Do not enable for files with more than n lines, integer
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
			timeoutlen = 0,
		},
		highlight_current_scope = { enable = true, timeout = 100 },
		smart_rename = { enable = true },
		navigation = { enable = true },
	},
	additional_vim_higlighting = true,
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.zimbu = {
	install_info = {
		url = "~/projects/tree-sitter-zimbu", -- local path or git repo
		files = { "src/parser.c" },
		-- optional entries:
		branch = "main", -- default branch in case of git repo if different from master
		generate_requires_npm = true, -- if stand-alone parser without npm dependencies
		requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
	},
	filetype = "zu", -- if filetype does not match the parser name
}
