--###########################################################################--
--						Luasnip HTML										 --
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
local file_type = "*.html"

ls.add_snippets("html", {
	s("!", {
	t({"<!DOCTYPE html>",
		"<html lang=\"en\">",
		"\t<head>",
		"\t\t<meta charset=\"utf-8\">",
		"\t\t<title>Untitle</title>",
		"\t\t<meta name=\"viwport\" content=\"width=device-width, initial-scale-1\">",
		"\t\t<link rel=\"stylesheet\" href=\"index.cssh\">",
		"\t</head>",
		"\t<body>",
			"\t\t\t<main>",
				"\t\t\t\t<h1>",
					"\t\t\t\t\t",
				"\t\t\t\t</h1>",
			"\t\t\t</main>",
		"\t</body>",
		"<html>",
	}) }),
})

