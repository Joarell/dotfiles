--###########################################################################--
--						   Appearance settings				 				 --
--###########################################################################--
-- Packer settings.
--
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


require("lualine").setup()
require("jj_neon_theme")
require("treesitter")
require("tabline")

--###########################################################################--
--						   Bufferline settings				 				 --
--###########################################################################--
-- require("bufferline").setup({
-- 	options = {
-- 		mode = "buffers", -- set to "tabs" to only show tabpages instead
-- 		numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
-- 		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
-- 		right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
-- 		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
-- 		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
-- 		buffer_close_icon = "",
-- 		modified_icon = "●",
-- 		close_icon = "",
-- 		left_trunc_marker = "",
-- 		right_trunc_marker = "",
-- 		indicator = {
-- 			-- icon = "▎", -- this should be omitted if indicator style is not 'icon'
-- 			-- style = "icon", -- can also be 'underline'|'none',
-- 			style = "icon", -- can also be 'underline'|'none',
-- 		},
-- 		--- name_formatter can be used to change the buffer's label in the bufferline.
-- 		--- Please note some names can/will break the
-- 		--- bufferline so use this at your discretion knowing that it has
-- 		--- some limitations that will *NOT* be fixed.
-- 		name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
-- 			-- remove extension from markdown files for example
-- 			if buf.name:match("%.md") then
-- 				return vim.fn.fnamemodify(buf.name, ":t:r")
-- 			end
-- 		end,
-- 		max_name_length = 18,
-- 		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
-- 		truncate_names = true, -- whether or not tab names should be truncated
-- 		tab_size = 18,
-- 		diagnostics = "nvim_lsp",
-- 		diagnostics_update_in_insert = false,
-- 		diagnostics_indicator = diagnostics_indicator,
-- 		-- NOTE: this will be called a lot so don't do any heavy processing here
-- 		custom_filter = custom_filter,
-- 		offsets = {
-- 			{
-- 				filetype = "undotree",
-- 				text = "Undotree",
-- 				highlight = "PanelHeading",
-- 				padding = 1,
-- 			},
-- 			{
-- 				filetype = "NvimTree",
-- 				text = "Explorer",
-- 				highlight = "PanelHeading",
-- 				padding = 1,
-- 			},
-- 			{
-- 				filetype = "DiffviewFiles",
-- 				text = "Diff View",
-- 				highlight = "PanelHeading",
-- 				padding = 1,
-- 			},
-- 			{
-- 				filetype = "flutterToolsOutline",
-- 				text = "Flutter Outline",
-- 				highlight = "PanelHeading",
-- 			},
-- 			{
-- 				filetype = "packer",
-- 				text = "Packer",
-- 				highlight = "PanelHeading",
-- 				padding = 1,
-- 			},
-- 		},
-- 		color_icons = true, -- whether or not to add the filetype icon highlights
-- 		show_close_icon = false,
-- 		show_tab_indicators = true,
-- 		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
-- 		-- can also be a table containing 2 custom separators
-- 		-- [focused and unfocused]. eg: { '|', '|' }
-- 		separator_style = "thin",
-- 		enforce_regular_tabs = false,
-- 		always_show_bufferline = true,
-- 		hover = {
-- 			enabled = false, -- requires nvim 0.8+
-- 			delay = 200,
-- 			reveal = { "close" },
-- 		},
-- 		sort_by = "id",
-- 	},
-- })


-- default configuration
-- require('illuminate').configure({
--     -- providers: provider used to get references in the buffer, ordered by priority
--     providers = {
--         'lsp',
--         'treesitter',
--         'regex',
--     },
--     -- delay: delay in milliseconds
--     delay = 50,
--     -- filetype_overrides: filetype specific overrides.
--     -- The keys are strings to represent the filetype while the values are tables that
--     -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
--     filetype_overrides = {},
--     -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
--     filetypes_denylist = {
--         'dirvish',
--         'fugitive',
--     },
--     -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
--     filetypes_allowlist = {},
--     -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
--     modes_denylist = {},
--     -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
--     modes_allowlist = {},
--     -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
--     -- Only applies to the 'regex' provider
--     -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
--     providers_regex_syntax_denylist = {},
--     -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
--     -- Only applies to the 'regex' provider
--     -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
--     providers_regex_syntax_allowlist = {},
--     -- under_cursor: whether or not to illuminate under the cursor
--     under_cursor = true,
--     -- large_file_cutoff: number of lines at which to use large_file_config
--     -- The `under_cursor` option is disabled when this cutoff is hit
--     large_file_cutoff = nil,
--     -- large_file_config: config to use for large files (based on large_file_cutoff).
--     -- Supports the same keys passed to .configure
--     -- If nil, vim-illuminate will be disabled for large files.
--     large_file_overrides = nil,
-- })
