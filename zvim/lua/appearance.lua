--###########################################################################--
--						   Appearance settings				 				 --
--###########################################################################--
-- vim.cmd([[
-- 	augroup packer_user_config
-- 		autocmd!
-- 		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
-- 	augroup end
-- ]])

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


-- -- Lua
-- require('onedark').setup({
-- 	-- Main options --
-- 	style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 	transparent = true, -- Show/hide background
-- 	term_colors = true, -- Change terminal color as per the selected theme style
-- 	ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
-- 	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
-- 	-- toggle theme style ---
-- 	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
-- 	-- Change code style ---
-- 	-- Options are italic, bold, underline, none
-- 	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
-- 	code_style = {
-- 		comments = 'italic',
-- 		keywords = 'bold',
-- 		-- keywords = 'bold',
-- 		functions = 'none',
-- 		strings = 'none',
-- 		variables = 'italic'
-- 	},
-- 	-- Lualine options --
-- 	lualine = {
-- 		transparent = true, -- lualine center bar transparency
-- 	},
-- 	-- Custom Highlights --
-- 	colors = {
-- 		bright_orange = "#ff8800", -- define a new color
-- 		green = '#00ffaa', -- redefine an existing color
-- 		purple = '#8e7cc3',
-- 		pink = '#f0554d',
-- 		yellow = '#dfc77f',
-- 		red = '#ff0000',
-- 		cyan = '#2EA2A9',
-- 		leaves = '#003964',
-- 		blue = '#59a0e5',
-- 		lemon = '#88aa11',
-- 		blue_func = '#0080ff',
-- 		gold = 'Gold',
-- 		grass = 'Green',
-- 		var = '#dbe0d9',
-- 	}, -- Override default colors
-- 	highlights = {
-- 		["@keyword"] = { fg = '$pink' },
-- 		["@keyword.function"] = { fg = '$blue_func' },
-- 		["@string"] = { fg = '$gold', fmt = 'italic' },
-- 		["@function"] = { fg = '$lemon', sp = '$cyan', fmt = 'bold' },
-- 		["@function.builtin"] = { fg = '$purple' },
-- 		["@lable"] = { fg = '$red'},
-- 		["@parameter"] = { fg = '$bright_orange'},
-- 		["@error"] = { fg = '$red'},
-- 		["@comment"] = { fg = '$grass'},
-- 		["@variable"] = { fg = '$var'},
-- 		["@danger"] = { fg = '$red'},
-- 	}, -- Override highlight groups
-- 	-- Plugins Config --
-- 	diagnostics = {
-- 		darker = true, -- darker colors for diagnostic
-- 		undercurl = true, -- use undercurl instead of underline for diagnostics
-- 		background = true, -- use background color for virtual text
-- 	},
-- })
-- require('onedark').load()


-- require("github-theme").setup({
-- 	transparent = true,
-- 	dark_float = true,
-- 	hide_end_of_buffer = true,
-- 	dark_sidebar = true,
-- 	variable_style = "NONE",
-- 	keyword_style = "bold",
-- 	-- theme_style = "dark_default",
-- 	theme_style = "dark",
-- 	function_style = "italic",
--
-- 	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- 	colors = { hint = "#33cccc", error = "#ff0000" },
--
-- 	-- Overwrite the highlight groups
-- 	overrides = function(c)
-- 		return {
-- 			htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
-- 			DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
-- 			-- this will remove the highlight groups
-- 			TSField = {},
-- 		}
-- 	end,
-- })


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
		separator_style = "slant",
	},
})


-- require('shade').setup({
-- 	overlay_opacity = 40,
-- 	opacity_step = 0.3,
-- 	keys = {
-- 		brightness_up   = '<C-Up>',
-- 		brightness_down = '<C-Down>',
-- 		toggle          = '<A-S>',
-- 	}
-- })

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
-- 	vim.nofity(res, vim.log.levels.ERROR)
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
