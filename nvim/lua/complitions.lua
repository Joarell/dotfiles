--###########################################################################--
--						AutoComplition Settings								 --
--###########################################################################--
-- Have a look in the "./plugins.lua", to set the new pluggins to LSP and snipets.
require("luasnip.loaders.from_vscode").lazy_load()
-- require("cmp_nvim_ultisnips").setup()

local cmp = require("cmp")
local luasnip = require("luasnip")
local snippy = require("cmp").setup()
local select_opts = { behavior = cmp.SelectBehavior.Select }


cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
			-- snippy.expand_snippet(args.body)
			-- vim.fn["vsnip#anonymoys"](args.body)
			-- vim.fn["ultiSnips#anon"](args.body)
		end,
	},

	sources = {
		{ name = "path", keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "snippy", keyword_length = 3 },
		{ name = "cmdline", keyword_length = 3 },
		{ name = "ultisnips", keyword_length = 3 },
		{ name = "Variable"},
		{ name = "Keyword"},
		{ name = "Snippet"},
		{ name = "Text"},
	},

	window = { documentation = cmp.config.window.bordered() },
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				cmdline = "  ",
				nvim_lsp = " ",
				luasnip = " ",
				buffer = "",
				path = "",
				Class = " ",
				Color = " ",
				Constant = "ﲀ ",
				Constructor = " ",
				Enum = "練",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = "",
				Folder = " ",
				Function = " ",
				Interface = "ﰮ ",
				Keyword = " ",
				Method = " ",
				Module = " ",
				Operator = "",
				Property = " ",
				Reference = " ",
				Snippet = " ",
				snippy = " ",
				Struct = " ",
				Text = " ",
				TypeParameter = " ",
				Unit = "塞",
				Value = " ",
				Variable = " ",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
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
		-- Movving between completion items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		['<C-d>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {'i', 's'}),
		['<C-b>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),
	},
})
