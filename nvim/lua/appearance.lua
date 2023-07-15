--  ╭──────────────────────────────────────────────────────────╮
--  │                   Appearance settings                    │
--  ╰──────────────────────────────────────────────────────────╯

-- Lua:
-- This is the theme for evential contention on neovim behavior. (Just in case!)

local c = require("vscode.colors").get_colors()
require("vscode").setup({
	-- Enable transparent background
	transparent = true,
	-- Enable italic comment
	italic_comments = true,
	-- Disable nvim-tree background color
	disable_nvimtree_bg = true,
	-- Override colors (see ./lua/vscode/colors.lua)
	color_overrides = {
		vscLineNumber = "#666561",
		-- vscPopupFront = '#00ffaa',
		vscPopupFront = '#0080ff',
		vscTabOutside = '#000000',
		vscTabCurrent = '#000000',
	},
	-- Override highlight groups (see ./lua/vscode/theme.lua)
	group_overrides = {
		-- this supports the same val table as vim.api.nvim_set_hl
		-- use colors from this colorscheme by requiring vscode.colors!
		Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true, italic = true },
	},
})
require('vscode').load('dark')


-- Example config in Lua
-- require('github-theme').setup({
-- 	options = {
-- 		transparent = true,
-- 		hide_end_of_buffer = true,
-- 		hide_nc_statusline = true,
-- 		styles = {
-- 			comments = 'italic, bold',
-- 			functions = 'NONE',
-- 			keywords = 'bold',
-- 			variables = 'underline',
-- 		},
-- 		darken = {
-- 			floats = true,
-- 			sidebars = {
-- 				enable = tr
-- 			},
-- 		},
-- 		specs = {
-- 			-- Change the color of only the 'github_dark' theme's 'hint' color to magenta and make the 'error' color a dim red.
-- 			github_dark = {
-- 				diag = {
-- 					error = '#660000',
-- 					hint = 'magenta.base',
-- 				},
-- 			},
-- 			-- Change the "hint" color to the "orange" color, and make the "error" color bright red.
-- 			all = {
-- 				diag = {
-- 					error = '#ff0000',
-- 					hint = 'orange',
-- 				},
-- 			},
-- 		},
-- 		-- Overwrite the highlight groups for all colorschemes
-- 		groups = {
-- 			all = {
-- 				htmlTag = { fg = 'palette.red', bg = '#282c34', sp = 'diag.hint', style = 'underline,bold' },
-- 				DiagnosticHint = { link = 'LspDiagnosticsDefaultHint' },
-- 				-- this will remove the highlight groups
-- 				TSField = {},
-- 			},
-- 		},
-- 	}
-- })

require("onedarkpro").setup({
	options = {
		cursorline = true,           -- Use cursorline highlighting?
		transparency = true,         -- Use a transparent background?
		terminal_colors = true,      -- Use the theme's colors for Neovim's :terminal?
		highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
	},
	highlights = {
		comment = {
			italic = true,
		},
	},
	styles = {
		keywords = "italic",
		variables = "italic",
	},
})
-- Default options
require('nightfox').setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		transparent = true,           -- Disable setting background
		terminal_colors = true,        -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = true,          -- Non focused panes set to alternative background
		module_default = false,         -- Default enable value for modules
		colorblind = {
			enable = true,            -- Enable colorblind support
			simulate_only = false,     -- Only show simulated colorblind colors and not diff shifted
			severity = {
				protan = 0,            -- Severity [0,1] for protan (red)
				deutan = 0,            -- Severity [0,1] for deutan (green)
				tritan = 0,            -- Severity [0,1] for tritan (blue)
			},
		},
		styles = {       -- Style to be applied to different syntax groups
			comments = "italic", -- Value is any valid attr-list value `:help attr-list`
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "italic",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "bold",
			variables = "NONE",
		},
		inverse = { -- Inverse highlight for different types
			match_paren = false,
			visual = false,
			search = false,
		},
		modules = { -- List of various plugins and additional options
			-- ...
		},
	},
	palettes = {},
	specs = {},
	groups = {},
})

-- setup must be called before loading
vim.cmd('colorscheme nightfox')

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
		show_close_icon = false,
		show_tab_indicators = true,
		separator_style = 'slant',
		mode = 'tabs',
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


require('shade').setup({
	overlay_opacity = 40,
	opacity_step = 0.3,
	keys = {
		brightness_up   = '<A-+>',
		brightness_down = '<A-->',
		toggle          = '<A-S>',
	}
})

require("jj_neon_theme")
require("treesitter")
require("tabline")

--###########################################################################--
--							Indent settings					 				 --
--###########################################################################--
require("virt-column").setup({})
local set = vim.opt
set.list = true
set.listchars:append("eol:↴")
set.listchars:append("space:•")

-- INFO: Not use feature at the momment.
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_end_of_line = true,
	show_current_context = true,
	show_current_context_start = true,
	-- char_highlight_list = {
	-- 	-- "IndentBlanklineIndent1",
	-- 	"IndentBlanklineIndent2",
	-- 	"IndentBlanklineIndent3",
	-- 	"IndentBlanklineIndent4",
	-- 	"IndentBlanklineIndent5",
	-- 	"IndentBlanklineIndent6",
	-- },
})

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

--###########################################################################--
--							Frame settings					 				 --
--###########################################################################--
require("nvim-comment-frame").setup({
	languages = {
		-- configuration for Lua programming language
		-- @NOTE global configuration will be overridden by language level
		-- configuration if provided
		lua = {
			-- start the comment with this string
			start_str = "--[[",
			-- end the comment line with this string
			end_str = "]]--",
			-- fill the comment frame border with this character
			fill_char = "*",
			-- width of the comment frame
			frame_width = 80,
			-- wrap the line after 'n' characters
			line_wrap_len = 70,
			-- automatically indent the comment frame based on the line
			auto_indent = false,
			-- add comment above the current line
			add_comment_above = false,
		},
		javascript = {
			-- start the comment with this string
			start_str = "//|",
			-- end the comment line with this string
			end_str = "|//",
			-- fill the comment frame border with this character
			fill_char = "*",
			-- width of the comment frame
			frame_width = 80,
			-- wrap the line after 'n' characters
			line_wrap_len = 70,
			-- automatically indent the comment frame based on the line
			auto_indent = false,
			-- add comment above the current line
			add_comment_above = false,
		},
	},
	-- if true, <leader>cf keymap will be disabled
	disable_default_keymap = false,
	-- start the comment with this string
	start_str = "//",
	-- end the comment line with this string
	end_str = "//",
	-- fill the comment frame border with this character
	fill_char = "-",
	-- width of the comment frame
	frame_width = 80,
	-- wrap the line after 'n' characters
	line_wrap_len = 80,
	-- automatically indent the comment frame based on the line
	auto_indent = true,
	-- add comment above the current line
	add_comment_above = true,
	-- configurations for individual language goes here
})

--[[************************************************************************]]
--[[                   Comment Pretty box design pluggin                    ]]
--[[                       Find some settings below.                        ]]
--[[************************************************************************]]
local status, frame_box = pcall(require, 'comment-box')

-- if not status and frame_box then
-- 	vim.notify(res, vim.log.levels.ERROR)
-- 	return
-- else
-- 	comment_box.setup({
-- 		doc_width = 80, -- width of the document
-- 		box_width = 60, -- width of the boxes
-- 		borders = { -- symbols used to draw a box
-- 			top = "─",
-- 			bottom = "─",
-- 			left = "│",
-- 			right = "│",
-- 			top_left = "╭",
-- 			top_right = "╮",
-- 			bottom_left = "╰",
-- 			bottom_right = "╯",
-- 		},
-- 		line_width = 70, -- width of the lines
-- 		line = { -- symbols used to draw a line
-- 			line = "─",
-- 			line_start = "─",
-- 			line_end = "─",
-- 		},
-- 		outer_blank_lines = false, -- insert a blank line above and below the box
-- 		inner_blank_lines = false, -- insert a blank line above and below the text
-- 		line_blank_line_above = false, -- insert a blank line above the line
-- 		line_blank_line_below = false, -- insert a blank line below the line
-- 	})
-- end
