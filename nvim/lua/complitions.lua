--###########################################################################--
--						AutoComplition Settings								 --
--###########################################################################--
-- Have a look in the "./plugins.lua", to set the new pluggins t LSP and snipets.
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")
local select_opts = { behavior = cmp.SelectBehavior.Select }

local compare = require("cmp.config.compare")
cmp.setup({
	sorting = {
		priority_weight = 2,
		comparators = {
			require("cmp_tabnine.compare"),
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
})

local tabnine = require("cmp_tabnine")
tabnine.setup({
	maxlines = 100,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	show_predictions = false,
})

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- snippy.expand_snippet(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "luasnip", option = { use_show_condition = false} },
		{ name = "buffer", keyword_length = 5 },
		{ name = "path", keyword_length = 3 },
		{ name = "cmdline", keyword_length = 3 },
		{ name = "dictionary", keyword_length = 3 },
		{ name = "ultisnips", keyword_length = 3 },
		{ name = "cmp_tabnine", keyword_length = 5 },
	},
	window = {
		complition = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		expandable_indicator = true,
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
			menu = {
				nvim_lsp = "[LSP]",
				luasnip = "[snip]",
				buffer = "[buf]",
				path = "[path]",
				cmdline = "[cmd]",
				dictionary = "[DICT]",
				cmp_tabnine = "[TabN]",
			},
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(select_opts),
		["<Tab>"] = cmp.mapping.select_next_item(select_opts),
		-- Scroll text in the documentation window.
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- Cancel completion
		["<C-e>"] = cmp.mapping.abort(),
		-- Moving between completion items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expand_or_jumpable() then
				ls.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})
