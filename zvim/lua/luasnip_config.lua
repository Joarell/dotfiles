--###########################################################################--
--						Luasnip Settings									 --
--###########################################################################--
local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

local types = require ("luasnip.util.types")

ls.config.set_config ({
	history = true,
	updateevents = "TextChanged, TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"ﲕ", "Error"}}
			},
		},
	},
	active = {
		hl_group = "GruvboxRen",
	},
	visited = {
		hl_group = "GrovboxBlue",
	},
	unvisited = {
		hl_group = "GrovboxGreen",
	},
})
