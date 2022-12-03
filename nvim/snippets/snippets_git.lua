--###########################################################################--
--								Luasnip Git.								 --
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
 
local group = vim.api.nvim_create_augroup("LuaSnippets", { clear = true})
local file_type = "COMMIT_EDITMSG"

ls.add_snippets("all", {
	s("git",
		fmt([[
			{} {}: {}
		]],
			{
				-- i(1, "type"),
				c(1, {t("build"),
					t("chore"),
					t("feat"),
					t("fix"),
					t("docs"),
					t("refactor"),
					t("perf"),
					t("style"),
				}),
				c(2, {t("scope"), i(1, "scope")}),
				i(3, "-- Commit message"),
			}
		)
	)}
)
