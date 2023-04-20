--###########################################################################--
--						Luasnip Lua											 --
--###########################################################################--
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.functions_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local group = vim.api.nvim_create_augroup("LuaSnippets", { clear = true })
local file_type = "*.lua"


ls.add_snippets("lua", {
	s("<!",
		fmt([[
			local {} = function({})
				{}
			end
		]],
			{
				i(1, "myVar"),
				c(2, {t(""), i(1, "myArg")}),
				i(3, "-- TODO: something"),
			}
		)
	)}
)
