--  ╭──────────────────────────────────────────────────────────╮
--  │                   Appearance settings                    │
--  ╰──────────────────────────────────────────────────────────╯
-- This module contains a number of default definitions
local rainbow_delimiters = require("rainbow-delimiters")

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	priority = {
		[""] = 110,
		lua = 210,
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
}

require("nightfox").setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		transparent = true,              -- Disable setting background
		terminal_colors = true,          -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = true,             -- Non focused panes set to alternative background
		module_default = false,          -- Default enable value for modules
		colorblind = {
			enable = false,                -- Enable colorblind support
			simulate_only = false,         -- Only show simulated colorblind colors and not diff shifted
			severity = {
				protan = 0,                  -- Severity [0,1] for protan (red)
				deutan = 0,                  -- Severity [0,1] for deutan (green)
				tritan = 0,                  -- Severity [0,1] for tritan (blue)
			},
		},
		styles = {          -- Style to be applied to different syntax groups
			comments = "italic", -- Value is any valid attr-list value `:help attr-list`
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "italic",
			numbers = "NONE",
			operators = "bold",
			strings = "NONE",
			types = "italic,bold",
			variables = "NONE",
		},
		inverse = { -- Inverse highlight for different types
			match_paren = true,
			visual = true,
			search = true,
		},
		-- modules = { -- List of various plugins and additional options
		-- 	barbar = {},
		-- 	-- ...
		-- },
	},
	-- palettes = {
	-- 	-- Custom duskfox with black background
	-- 	nightfox = {
	-- 		bg1 = "#000000", -- Black background
	-- 		bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
	-- 		bg3 = "#121820", -- 55% darkened from stock
	-- 		sel0 = "#131b24", -- 55% darkened from stock
	-- 	},
	-- 	specs = {
	-- 		all = {
	-- 			inactive = "bg0", -- Default value for other styles
	-- 		},
	-- 		nightfox = {
	-- 			inactive = "#090909", -- Slightly lighter then black background
	-- 		},
	-- 	},
	-- 	groups = {
	-- 		all = {
	-- 			NormalNC = { fg = "fg1", bg = "inactive" }, -- Non-current windows
	-- 		},
	-- 	},
	-- },
	specs = {},
	groups = {},
})


require("solarized-osaka").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	transparent = true,    -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = { bold = true },
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark",             -- style for sidebars, see below
		floats = "dark",               -- style for floating windows
	},
	sidebars = { "qf", "help" },     -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3,            -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false,            -- dims inactive windows
	lualine_bold = true,             -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})

require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "storm",       -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day",   -- The theme is used when the background is set to light
	transparent = false,   -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark",             -- style for sidebars, see below
		floats = "dark",               -- style for floating windows
	},
	sidebars = { "qf", "help" },     -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3,            -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false,            -- dims inactive windows
	lualine_bold = false,            -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})

-- Default options:
require("kanagawa").setup({
	compile = true,  -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false,  -- do not set background color
	dimInactive = false,  -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = {            -- add/modify theme and palette colors
		palette = {},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	},
	overrides = function(colors) -- add/modify highlights
		return {}
	end,
	theme = "wave", -- Load "wave" theme when 'background' option is not set
	background = { -- map the value of 'background' option to a theme
		dark = "wave", -- try "dragon" !
		light = "lotus",
	},
})

require("material").setup({
	contrast = {
		terminal = false,          -- Enable contrast for the built-in terminal
		sidebars = false,          -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false,  -- Enable contrast for floating windows
		cursor_line = false,       -- Enable darker background for the cursor line
		lsp_virtual_text = false,  -- Enable contrasted background for lsp virtual text
		non_current_windows = false, -- Enable contrasted background for non-current windows
		filetypes = {},            -- Specify which filetypes get the contrasted (darker) background
	},

	styles = { -- Give comments style such as bold, italic, underline etc.
		comments = { --[[ italic = true ]]
		},
		strings = { --[[ bold = true ]]
		},
		keywords = { --[[ underline = true ]]
		},
		functions = { --[[ bold = true, undercurl = true ]]
		},
		variables = {},
		operators = {},
		types = {},
	},

	plugins = { -- Uncomment the plugins that you use to highlight them
		-- Available plugins:
		-- "dap",
		-- "dashboard",
		-- "eyeliner",
		-- "fidget",
		-- "flash",
		-- "gitsigns",
		-- "harpoon",
		-- "hop",
		-- "illuminate",
		-- "indent-blankline",
		-- "lspsaga",
		-- "mini",
		-- "neogit",
		-- "neotest",
		-- "neo-tree",
		-- "neorg",
		-- "noice",
		-- "nvim-cmp",
		-- "nvim-navic",
		-- "nvim-tree",
		-- "nvim-web-devicons",
		-- "rainbow-delimiters",
		-- "sneak",
		-- "telescope",
		-- "trouble",
		-- "which-key",
		-- "nvim-notify",
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false,      -- Disable borders between vertically split windows
		background = false,   -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
		term_colors = false,  -- Prevent the theme from setting terminal colors
		eob_lines = false,    -- Hide the end-of-buffer lines
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false, -- Enable higher contrast text for darker style
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true,     -- Load parts of the theme asynchronously for faster startup (turned on by default)

	custom_colors = nil,      -- If you want to override the default colors, set this to a function

	custom_highlights = {},   -- Overwrite highlights with your own
})

vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme solarized-osaka")
-- vim.cmd("colorscheme retrobox")
-- vim.cmd("colorscheme kanagawa-dragon")

--  ╭──────────────────────────────────────────────────────────╮
--  │                   Bufferline settings:                   │
--  ╰──────────────────────────────────────────────────────────╯
require("bufferline").setup({
	options = {
		buffer_close_icon = "",
		close_command = "Bdelete %d",
		close_icon = "",
		indicator = {
			style = "icon",
			icon = " ",
		},
		left_trunc_marker = "",
		modified_icon = "●",
		offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
		right_mouse_command = "Bdelete! %d",
		right_trunc_marker = "",
		show_close_icon = true,
		show_tab_indicators = true,
		separator_style = "slant",
		mode = "tabs",
		color_icons = true,
	},
	highlights = {
		fill = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLineNC" },
		},
		background = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLine" },
		},
		buffer_visible = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		buffer_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		separator = {
			fg = { attribute = "bg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLine" },
		},
		separator_selected = {
			fg = { attribute = "fg", highlight = "Special" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		separator_visible = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLineNC" },
		},
		close_button = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "StatusLine" },
		},
		close_button_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		close_button_visible = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
	},
})

-- require('shade').setup({
-- 	overlay_opacity = 40,
-- 	opacity_step = 0.3,
-- 	keys = {
-- 		brightness_up   = '<A-+>',
-- 		brightness_down = '<A-->',
-- 		toggle          = '<A-S>',
-- 	}
-- })

require("jj_neon_theme")
require("tabline")
local ok = pcall(require, "treesitter")
if ok then
	require("treesitter")
end

--###########################################################################--
--							Indent settings					 				 --
--###########################################################################--
-- require("virt-column").setup({})
-- local set = vim.opt
--
-- local highlight = {
-- 	"RainbowRed",
-- 	"RainbowYellow",
-- 	"RainbowBlue",
-- 	"RainbowOrange",
-- 	"RainbowGreen",
-- 	"RainbowViolet",
-- 	"RainbowCyan",
-- }

-- local hooks = require("ibl.hooks")
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- 	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
-- 	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
-- 	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
-- 	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
-- 	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
-- 	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
-- 	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
-- end)
--
vim.g.rainbow_delimiters = { highlight = highlight }
-- require("ibl").setup({
-- 	indent = {
-- 		tab_char = "▎",
-- 		priority = 1,
-- 	},
-- 	whitespace = {
-- 		highlight = { "Whitespace", "NonText" },
-- 		remove_blankline_trail = true,
-- 	},
-- 	scope = {
-- 		enabled = true,
-- 		show_start = true,
-- 		show_end = false,
-- 		injected_languages = false,
-- 		highlight = highlight,
-- 		priority = 500,
-- 	},
-- })
--
-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

--###########################################################################--
--							Fold settings					 				 --
--###########################################################################--
require("pretty-fold").setup({
	keep_indentation = false,
	fill_char = "━",
	sections = {
		left = {
			"━ ",
			function()
				return string.rep("*", vim.v.foldlevel)
			end,
			" ━┫",
			"content",
			"┣",
		},
		right = {
			"┫ ",
			"number_of_folded_lines",
			": ",
			"percentage",
			" ┣━━",
		},
	},
})
