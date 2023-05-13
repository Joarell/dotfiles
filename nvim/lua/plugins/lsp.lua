--  ╭──────────────────────────────────────────────────────────╮
--  │                 LSP and autocomplitions.                 │
--  ╰──────────────────────────────────────────────────────────╯

return {
	-- {'VonHeikemen/Lsp-zero.nvim', branch = 'v1.x'},
	{
		"https://github.com/L3MON4D3/LuaSnip",
		version = "1.2.1.*",
		build = "make install_jsregexp",
		dependencies = {
			"dcampos/cmp-snippy",
			"dcampos/nvim-snippy",
			"hrsh7th/cmp-vsnip",
			"rafamadriz/friendly-snippets",
			"SirVer/ultisnips",
			"saadparwaiz1/cmp_luasnip",
			"quangnguyen30192/cmp-nvim-ultisnips",
		},
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
			-- "https://github.com/jcha0713/cmp-tw2css",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"windwp/nvim-ts-autotag",
			"https://github.com/onsails/lspkind.nvim",
			"uga-rosa/cmp-dictionary",
			"shinglyu/vim-codespell",
			-- {
			-- 	"roobert/tailwindcss-colorizer-cmp.nvim",
			-- 	config = function ()
			-- 		require("tailwindcss-colorizer-cmp").setup({
			-- 			color_square_width = 2,
			-- 		})
			-- 	end
			-- },
			-- {
			-- 	"tzachar/cmp-tabnine",
			-- 	build = "./install.sh",
			-- 	dependencies = "hrsh7th/nvim-cmp"
			-- },
		},
		config = function ()
			require("luasnip/loaders/from_vscode").lazy_load()
			-- require("cmp-tw2css").setup({
			-- 	fallback = true
			-- })

			local lspkind = require("lspkind")
			local cmp = require ("cmp")
			local ls = require ("luasnip")
			local dict = require("cmp_dictionary")
			-- local tailwind_ok, tailwindcss = pcall(require, "tailwindcss-colorizer-cmp")
			-- if not tailwind_ok then
			-- 	return
			-- end
			-- local tabnine = require("cmp_tabnine.config")
			--
			-- tabnine:setup({
			-- 	max_lines = 1000,
			-- 	max_num_results = 20,
			-- 	sort = true,
			-- 	run_on_every_keystroke = true,
			-- 	snippet_placeholder = '..',
			-- 	ignored_file_type = {},
			-- 	show_prediction_strength = false,
			-- })

			dict.setup({
				exact = 3,
				first_case_insensitive = false,
				document = false,
				document_command = "wn %s -over",
				async = false,
				max_items = -1,
				capacity = 5,
				debug = false,
			})
			dict.switcher({
				spelllang = {
					en = "~/dotfiles/en.dict",
				},
				filepath = {
					["*"] = "~/dotfiles/en.dict",
				},
			})

			ls.config.setup({
				history = true,
				update_events = "TextChanged, TextChangedI",
			})
			cmp.setup({
				snippet = {
					expand = function(args)
						if not ls then
							return
						end
						ls.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp", group_index = 0},
					{ name = "buffer", keyword_length = 3, group_index = 1 },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "cmdline", keyword_length = 3, group_index = 2},
					{ name = "path" },
					{ name = "emoji", option = { insert = false } },
					-- { name = "cmp-tw2css", group_index = 3},
					{ name = "dictionary", keyword_length = 4 },
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
						maxwidth = 55,
						withe_text = true,
						ellipsis_char = "...",
						menu = {
							nvim_lsp = "   ",
							luasnip = "   ",
							buffer = "   ",
							path = "󰺽 󰑪  ",
							cmdline = " ",
							dictionary = "  ",
							emoji = "   ",
							-- cmp_tw2css = "󱠓  ",
							-- cmp_tabnine = "",
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
					["<C-l>"] = cmp.mapping(function(fallback)
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
					["<C-h>"] = cmp.mapping(function(fallback)
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
			cmp.setup.cmdline ({'/', '?'}, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
			cmp.setup.cmdline (':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources ({
					{ name = 'path' }
				},{
					{ name = 'cmdline' }
				})
			})
		end,
	},
}
