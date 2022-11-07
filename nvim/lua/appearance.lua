--###########################################################################--
--						   Appearance settings				 				 --
--###########################################################################--
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Lua:
-- This is the theme for evential contention on neovim behavior. (Just in case!)
local c = require("vscode.colors")
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
	},

	-- Override highlight groups (see ./lua/vscode/theme.lua)
	group_overrides = {
		-- this supports the same val table as vim.api.nvim_set_hl
		-- use colors from this colorscheme by requiring vscode.colors!
		Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
	},
})

-- Example config in Lua
require("github-theme").setup({
	transparent = true,
	dark_float = true,
	hide_end_of_buffer = true,
	dark_sidebar = true,
	variable_style = "NONE",
	keyword_style = "bold",
	theme_style = "dark_default",
	-- theme_style = "dark",
	function_style = "italic",

	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	colors = { hint = "#33cccc", error = "#ff0000" },

	-- Overwrite the highlight groups
	overrides = function(c)
		return {
			htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
			DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
			-- this will remove the highlight groups
			TSField = {},
		}
	end,
})


require("lualine").setup({
	sections = {
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = {fg = "#ff9e64"},
			},
		}
	}
})

require("jj_neon_theme")
require("treesitter")
require("tabline")

--###########################################################################--
--							Indent settings					 				 --
--###########################################################################--
local set = vim.opt
set.list = true
set.listchars:append("eol:↴")
set.listchars:append("space:•")

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

require("indent_blankline").setup({
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
