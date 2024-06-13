--  ╭──────────────────────────────────────────────────────────╮
--  │                   Treesitter Settings.                   │
--  ╰──────────────────────────────────────────────────────────╯

require("nvim-treesitter.configs").setup({ -- Here is all languages suportted. Feel free to update it.
	auto_install = true,
	-- ensure_installed = {
	-- 	"bash",
	-- 	"c",
	-- 	"javascript",
	-- 	"json",
	-- 	"lua",
	-- 	"python",
	-- 	"typescript",
	-- 	"tsx",
	-- 	"css",
	-- 	"html",
	-- 	"http",
	-- 	"rust",
	-- 	"java",
	-- 	"yaml",
	-- 	"markdown",
	-- 	"kotlin",
	-- 	"yaml",
	-- 	"rust",
	-- 	"cmake",
	-- 	"vim",
	-- 	"regex",
	-- },
	sync_install = true,
	indent = { enable = true },
	ignore_install = { "cpp" },
	highlight = {
		enable = true, -- false will disble the whole extension
		additional_vim_regex_highlighting = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100kb
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end
	},
	rainbow = {
		enable = true,
		-- disable = {"jsx", "cpp"}, list of languages you want to disable the plugin for
		extended_mode = true, -- Also higlight non-bracket delimiters.
		-- max_file_lines = nil, -- Do not enable for files with more than n lines, integer
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
		strategy = require('ts-rainbow').strategy.global,
		hlgroups = {
			'TSRainbowRed',
			'TSRainbowYellow',
			'TSRainbowBlue',
			'TSRainbowOrange',
			'TSRainbowGreen',
			'TSRainbowViolet',
			'TSRainbowCyan',
		},
	},
	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
		filetypes = { "html" },
	},
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = false,
			timeoutlen = 0,
		},
		-- highlight_current_scope = { enable = true, timeout = 100 },
		smart_rename = {
			enable = true,
			-- keymaps = {
			-- 	smart_rename = "cn"
			-- },
		},
		navigation = {
			enable = true,
			keymaps = {
				list_definiitons = "gO",
			},
		},
	},
	additional_vim_higlighting = true,
	textobjects = {
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				--
				-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
				["]o"] = "@loop.*",
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				--
				-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
				-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			-- Below will go to either the start or the end, whichever is closer.
			-- Use if you want more granular movements
			-- Make it even more gradual by adding multiple queries and regex.
			goto_next = {
				["]d"] = "@conditional.outer",
			},
			goto_previous = {
				["[d"] = "@conditional.outer",
			}
		},
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.zimbu = {
	install_info = {
		url = "~/projects/tree-sitter-zimbu", -- local path or git repo
		files = { "src/parser.c" },
		-- optional entries:
		branch = "main",                 -- default branch in case of git repo if different from master
		generate_requires_npm = true,    -- if stand-alone parser without npm dependencies
		requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
	},
	filetype = "zu",                     -- if filetype does not match the parser name
}

--###########################################################################--
--							Regex Settings		 							 --
--###########################################################################--
require("regexplainer").show { display = 'popup' }
require("regexplainer").setup({
	-- 'narrative'
	mode = "narrative", -- TODO: 'ascii', 'graphical'

	-- automatically show the explainer when the cursor enters a regexp
	auto = true,

	-- filetypes (i.e. extensions) in which to run the autocommand
	filetypes = {
		"lua",
		"html",
		"js",
		"cjs",
		"mjs",
		"ts",
		"jsx",
		"tsx",
		"cjsx",
		"mjsx",
		"sh",
		"yml",
		"markdown",
	},

	-- Whether to log debug messages
	debug = true,

	display = "popup",
	popup = {
		border = {
			padding = { 1, 2 },
			style = 'rounded',
		},
	},

	mappings = {
		-- toggle = "gR",
		-- examples, not defaults:
		-- show = 'gS',
		-- hide = 'gH',
		-- show_split = 'gP',
		-- show_popup = 'gU',
	},

	narrative = {
		separator = "\n",
	},
})
--###########################################################################--
--							Autopairs Settings	 							 --
--###########################################################################--
local filetypes = {
	"html",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
	"tsx",
	"jsx",
	"rescript",
	"xml",
	"php",
	"markdown",
	"glimmer",
	"handlebars",
	"hbs",
	"markdown",
}
local skip_tags = {
	"area",
	"base",
	"br",
	"col",
	"command",
	"embed",
	"hr",
	"img",
	"slot",
	"input",
	"keygen",
	"link",
	"meta",
	"param",
	"source",
	"track",
	"wbr",
	"menuitem",
	"markdown",
}
