--  ╭──────────────────────────────────────────────────────────╮
--  │                 LSP and autocomplitions.                 │
--  ╰──────────────────────────────────────────────────────────╯

return {
	-- {'VonHeikemen/Lsp-zero.nvim', branch = 'v1.x'},
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh ./install.sh",
		config = function()
			require("sniprun").setup({
				display = { "NvimNotify" },
				display_options = { notification_timeout = 5 }, -- in seconds
			})
		end,
	},
	{
		"https://github.com/L3MON4D3/LuaSnip",
		version = "1.2.1.*",
		build = "make install_jsregexp",
		dependencies = {
			-- "dcampos/cmp-snippy",
			-- "dcampos/nvim-snippy",
			"rafamadriz/friendly-snippets",
			"SirVer/ultisnips",
			-- "honza/vim-snippets",
			"saadparwaiz1/cmp_luasnip",
			"quangnguyen30192/cmp-nvim-ultisnips",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"p00f/clangd_extensions.nvim",
				-- "Smiteshp/nvim-navbuddy",
				dependencies = {
					"smiteshp/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
		},
		config = function()
			require("clangd_extensions.inlay_hints").setup_autocmd()
			require("clangd_extensions.inlay_hints").set_inlay_hints()
		end,
	},
	{
		"bennypowers/nvim-regexplainer",
		config = function()
			require("regexplainer").setup()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/vim-vsnip",
			"hrsh7th/vim-vsnip-integ",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"windwp/nvim-ts-autotag",
			"https://github.com/onsails/lspkind.nvim",
			"uga-rosa/cmp-dictionary",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			vim.o.completeopt = "menuone,noinsert,noselect"

			local lspkind = require("lspkind")
			local cmp = require("cmp")
			local ls = require("luasnip")
			local dict = require("cmp_dictionary")

			dict.setup({
				paths = { "/home/jev/dotfiles/en.dict" },
				exact_length = 2,
				first_case_insensitive = true,
				document = {
					enable = true,
					command = { "wn", "${label}", "-over" },
				},
			})

			ls.config.setup({
				history = true,
				update_events = "TextChanged, TextChangedI",
			})
			cmp.setup({
				snippet = {
					expand = function(args)
						-- if not ls then
						-- 	return vim.fn["UtilSnips#Anon"](args.body)
						-- end
						-- ls.lsp_expand(args.body)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp",               keyword_length = 1 },
					{ name = "nvim_lua",               keyword_length = 3 },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer",                 keyword_length = 3,         group_index = 1 },
					{ name = "luasnip",                keyword_length = 2 },
					{ name = "vsnip",                  keyword_length = 2 },
					-- { name = "utisnips",              keyword_length = 2 },
					{ name = "cmdline",                keyword_length = 3,         group_index = 2 },
					{ name = "path",                   keyword_length = 3 },
					{ name = "emoji",                  option = { insert = false } },
					{ name = "vim-dadbod-completion" },
					{ name = "dictionary",             keyword_length = 3 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					expandable_indicator = true,
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "text_symbol",
						maxwidth = 35,
						withe_text = true,
						ellipsis_char = "...",
						menu = {
							nvim_lsp = "    ",
							nvim_lsp_signature_help = "  ",
							vsnip = "    ",
							DB = "DATA",
							-- utisnips = " ",
							nvim_lua = "   ",
							luasnip = "   ",
							buffer = "   ",
							path = "󰺽 󰑪  ",
							cmdline = " ",
							dictionary = "  ",
							emoji = "   ",
						},
						-- before = function (entry, vim_item)
						-- 	vim_item = tailwindcss.formatter(entry, vim_item)
						-- 	return vim_item
						-- end
						before = function(_, vim_item)
							return vim_item
						end,
					}),
				},
				experimental = {
					native_menu = false,
					ghost_text = true,
				},
				sorting = {
					priority_weight = 2,
					comparator = {
						cmp.config.compare.recently_used,
						require("clangd_extensions.cmp_scores"),
						cmp.config.compare.score,
						cmp.config.compare.offset,
						cmp.config.compare.kind,
						cmp.config.compare.locality,
						cmp.config.compare.sort_text,
						cmp.config.compare.order,
						cmp.config.compare.exact,
						cmp.config.compare.length,
					},
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
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif ls.expand_or_jumpable() then
							ls.expand_or_jump()
						elseif ls.has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping(function(fallback)
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
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
