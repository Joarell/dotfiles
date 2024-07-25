--###########################################################################--
-- 							Lua line		 								 --
--###########################################################################--

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")


-- Color table for highlights
-- stylua: ignore
local colors = {
	-- bg       = '#202328',
	bg       = '',
	fg       = '#bbc2cf',
	yellow   = 'Yellow',
	cyan     = '#008080',
	darkblue = '#33cccc',
	green    = '#33cc33',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
	pink     = '#c90076',
	purple   = 'Purple',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {
			{
				require("noice").api.status.mode.get,
				cond = require("noice").api.status.mode.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.command.get,
				cond = require("noice").api.status.command.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.search.get,
				cond = require("noice").api.status.search.has,
				color = { fg = "#ff9e64" },
			},
		},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- Inserts a color in lualine_x at right section
local function change_colors(component, side)
	if side == "left" then
		ins_left({
			component,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.darkblue,
					i = colors.green,
					v = colors.purple,
					["␖"] = colors.blue,
					V = colors.blue,
					c = colors.orange,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					["␓"] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { left = 0, right = 1 }, -- We don't need space before this
		})
	elseif side == "right" then
		ins_right({
			component,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.darkblue,
					i = colors.green,
					v = colors.purple,
					["␖"] = colors.blue,
					V = colors.blue,
					c = colors.orange,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					["␓"] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { left = 1, right = 0 }, -- We don't need space before this
		})
	end
end

local comp = function()
	return "   "
end
change_colors(comp, "left")



change_colors("mode", "left")

local comp = function()
	return "  "
end
change_colors(comp, "left")

ins_left({
	"branch",
	icon = " ",
	-- icon = ' ',
	-- icon = 'ﳎ ',
	color = { fg = colors.violet, gui = "bold" },
})


ins_left({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

local getpath = vim.fn.expand("%:p:h")
local getgit = vim.fn.finddir('.git', getpath .. ';')
if (#getgit > 0) then
	local comp = function()
		return "   "
	end
	change_colors(comp, "left")
end


local comp = function()
	return "󰒲    󰲉  󰘨      "
end
change_colors(comp, "left")


local comp = function()
	return " "
end
change_colors(comp, "left")



-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_right {
-- 	function()
-- 		return string.format(" %3d:%-2d ", map(_, vim.api.nvim_win_get_cursor(0)))
-- 		-- return '%='
-- 	end,
-- }
-- local comp = function()
-- 	return '%='
-- end
-- change_colors(comp, "right")


-- Add components to right sections
local comp = function()
	return " 󰂵"
end
change_colors(comp, "right")


ins_right({
	-- filesize component
	"filesize",
	padding = { left = 1 },
	cond = conditions.buffer_not_empty,
	icon = "size:",
})


local comp = function()
	return "󰂵  "
end
change_colors(comp, "right")

local comp = function()
	return "  "
end
change_colors(comp, "right")


ins_right({
	"diagnostics",
	sources = { 
		"nvim_diagnostic",
	},
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.orange },
		color_info = { fg = colors.cyan },
	},
})


ins_right {
	'o:encoding',    -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = 'bold' },
}

local comp = function()
	return "  "
end
change_colors(comp, "right")

ins_right({
	-- Lsp server name .
	function()
		local msg = ''
		-- local msg = " "
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes or {}
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return clients.name
	end,
	-- icon = ' LSP  ',
	-- icon = ' LSP  ',
	icon = " LSP ",
	color = { fg = colors.pink, gui = "bold" },
})


local comp = function()
	return "  "
end
change_colors(comp, "right")

-- ins_right({
-- 	"fileformat",
-- 	fmt = string.upper,
-- 	-- icon = "",
-- 	icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
-- 	color = { fg = colors.blue, gui = "bold" },
-- })
--
-- local comp = function()
-- 	return "   "
-- end
-- change_colors(comp, "right")


ins_right({ "filetype" })


local comp = function()
	return "  "
end
change_colors(comp, "right")


ins_right({ "location" })
local comp = function()
	return "  "
end
change_colors(comp, "right")

ins_right({ "progress", color = { fg = colors.fg, gui = "bold" } })

local comp = function()
	return " "
end
change_colors(comp, "right")

-- Now don't forget to initialize lualine
lualine.setup(config)
