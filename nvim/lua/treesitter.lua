--###########################################################################--
-- 							Treesitter Settings		 						 --
--###########################################################################--
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
	sync_install = false,
	indent = { enable = true },
	highlight = {
		enable = true, -- false will disble the whole extension
		additional_vim_regex_highlighting = true,
		disable = function (_, buf)
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
		filetypes = filetypes,
		skip_tags = skip_tags,
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

--###########################################################################--
--							Regex Settings		 							 --
--###########################################################################--
require("regexplainer").show{ display = 'popup' }
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
			padding = {1, 2},
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
