--###########################################################################--
--						AutoComplition Settings								 --
--###########################################################################--
require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
	snippet = { expand = function(args)
		luasnip.lsp_expand(args.body)
	end
	},

	sources = {
		{ name = 'path'},
		{ name = 'nvim_lsp'},
		{ name = 'buffer'},
		{ name = 'luasnip'},
		{ name = 'cmp_tabnine'},
		{ name = 'nvim_lua'},
		{ name = 'calc'},
		{ name = 'emoji'},
		{ name = 'treesitter'},
		{ name = 'crates'},
		{ name = 'tmux'},
		{ name = 'Method'},
	},

	window = { documentation = cmp.config.window.bordered() },
	formatting = {
		fields = { 'kind', 'menu', 'abbr'},
		format = function(entry, item)
			local kind_icon = {
				-- nvim_lsp = ' ',
				nvim_lsp = ' ',
				luasnip = ' ',
				buffer = '',
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
				Struct = " ",
				Text = " ",
				TypeParameter = " ",
				Unit = "塞",
				Value = " ",
				Variable = " ",
			}
			item.kind = kind_icon[entry.source.name]
			return item
		end,
	},

	mapping = {
		['<S-Tab>'] = cmp.mapping.select_prev_item(select_opts),
		['<Tab>'] = cmp.mapping.select_next_item(select_opts),
		-- Scroll text in the documentation window.
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- Cancel completion
		['<C-e>'] = cmp.mapping.abort(),
		-- Movving between completion items.
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}
}
