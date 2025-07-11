--  ╭──────────────────────────────────────────────────────────╮
--  │                      Lazy Settings.                      │
--  ╰──────────────────────────────────────────────────────────╯

return {
	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		Discord app monitor								   │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "ThePrimeagen/vim-be-good" },
	{ "hsanson/vim-android" },
	-- {
	-- 	"rust-lang/rust.vim",
	-- 	ft = "rust",
	-- 	config = function ()
	-- 		vim.g.rustfmt_autosave = 1
	-- 	end
	-- },
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
	},
	-- {
	-- 	"lpturmel/discord.nvim",
	-- 	config = function()
	-- 		local discord = require("discord")
	-- 		discord.setup({})
	-- 	end,
	-- },
	-- {
	-- 	"IogaMaster/neocord", event = "VeryLazy",
	-- },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		icons                                              │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "nvim-tree/nvim-web-devicons" },

	-- You can specify multiple plugins in a single call
	{
		"nvim-treesitter/nvim-treesitter",
		-- build = function()
		-- 	local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		-- 	ts_update()
		-- end,
		build = ":TSUpdate",
		dependencies = {
			{"nushell/tree-sitter-nu", build = ":TSUpdate nu"},
			{"tree-sitter-grammars/tree-sitter-hyprlang", build = ":TSUpdate hyprlang"},
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-refactor",
			-- "nvim-treesitter/nvim-treesitter-textobjects",
			"HiPhish/rainbow-delimiters.nvim",
			"windwp/nvim-ts-autotag",
		},
	},
	-- { "nvim-treesitter/playground" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		Lua status line/column                             │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"folke/trouble.nvim",
			"nvim-tree/nvim-web-devicons",
			opt = true,
		},
		-- opts = function (_, opts)
		-- 	local trouble = require("trouble")
		-- 	local symbols = trouble.statusline({
		-- 		mode = "lsp_document_symbols",
		-- 		groups = {},
		-- 		title = false,
		-- 		filter = { ranger = true },
		-- 		format = "{kind_icon}{symbol.name:Normal}",
		-- 		hl_group = "lualine_c_normal",
		-- 	})
		-- 	table.insert(opts.sections.lualine_c, {
		-- 		symbols.get,
		-- 		cond = symbols.has,
		-- 	})
		-- end,
	},
	-- {
	-- 	{
	-- 		"sourcegraph/sg.nvim",
	-- 		dependencies = {
	-- 			"nvim-lua/plenary.nvim", --[[ "nvim-elescope/telescope.nvim ]]
	-- 		},
	-- 	},
	-- },
	-- { "luukvbaal/statuscol.nvim" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = {},
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		BufferLine                                         │
	--  ╰──────────────────────────────────────────────────────────╯
	-- { "akinsho/bufferline.nvim", version = "*", dependenciess = "nvim-tree/nvim-web-devicons" },
	-- {
	-- 	"tiagovla/scope.nvim",
	-- 	config = function ()
	-- 		vim.opt.sessionoptions = {
	-- 			"buffers",
	-- 			"tabpages",
	-- 			"globals",
	-- 		}
	-- 		require("scope").setup({})
	-- 	end,
	-- },
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		config = function()
			require("barbar").setup({
				-- Enable/disable animations
				animation = true,

				-- Enable/disable auto-hiding the tab bar when there is a single buffer
				auto_hide = false,

				-- Enable/disable current/total tabpages indicator (top right corner)
				tabpages = false,

				-- Enables/disable clickable tabs
				--  - left-click: go to buffer
				--  - middle-click: delete buffer
				clickable = true,

				-- Excludes buffers from the tabline
				-- exclude_ft = { 'javascript' },
				-- exclude_name = { 'package.json' },

				-- A buffer to this direction will be focused (if it exists) when closing the current buffer.
				-- Valid options are 'left' (the default) and 'right'
				focus_on_close = "left",

				-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
				hide = { extensions = false, inactive = true },

				-- Disable highlighting alternate buffers
				highlight_alternate = false,

				-- Disable highlighting file icons in inactive buffers
				highlight_inactive_file_icons = true,

				-- Enable highlighting visible buffers
				highlight_visible = true,

				icons = {
					-- Configure the base icons on the bufferline.
					buffer_index = false,
					buffer_number = false,
					button = "  ",
					-- Enables / disables diagnostic symbols
					diagnostics = {
						[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ " },
						[vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
						[vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
						[vim.diagnostic.severity.HINT] = { enabled = true, icon = " " },
					},
					-- gitsigns = {
					-- 	added = { enabled = false, icon = "+" },
					-- 	changed = { enabled = false, icon = "~" },
					-- 	deleted = { enabled = false, icon = "-" },
					-- },
					filetype = {
						-- Sets the icon's highlight group.
						-- If false, will use nvim-web-devicons colors
						custom_colors = false,
						-- Requires `nvim-web-devicons` if `true`
						enabled = true,
					},
					separator = { left = "▎", right = "" },
					-- Configure the icons on the bufferline when modified or pinned.
					-- Supports all the base icon options.
					modified = { button = "󰐾 " },
					preset = "slanted",
					pinned = { button = "車", filename = true, separator = { right = "" } },
					-- Configure the icons on the bufferline based on the visibility of a buffer.
					-- Supports all the base icon options, plus `modified` and `pinned`.
					alternate = { filetype = { enabled = false } },
					current = { buffer_index = false },
					inactive = { button = "×" },
					visible = { modified = { buffer_number = false } },
				},

				-- If true, new buffers will be inserted at the start/end of the list.
				-- Default is to insert after current buffer.
				insert_at_end = true,
				insert_at_start = false,

				-- Sets the maximum padding width with which to surround each tab
				maximum_padding = 1,

				-- Sets the minimum padding width with which to surround each tab
				minimum_padding = 5,

				-- Sets the maximum buffer name length.
				maximum_length = 30,

				-- If set, the letters for each buffer in buffer-pick mode will be
				-- assigned based on their name. Otherwise or in case all letters are
				-- already assigned, the behavior is to assign letters in order of
				-- usability (see order below)
				semantic_letters = true,

				-- Set the filetypes which barbar will offset itself for
				sidebar_filetypes = {
					-- Use the default values: {event = 'BufWinLeave', text = nil}
					NvimTree = false,
					-- Or, specify the text used for the offset:
					undotree = { text = "undotree" },
					-- Or, specify the event which the sidebar executes when leaving:
					["neo-tree"] = { event = "BufWipeout" },
					-- Or, specify both
					Outline = { event = "BufWinLeave", text = "symbols-outline" },
				},

				-- New buffer letters are assigned in this order. This order is
				-- optimal for the qwerty keyboard layout but might need adjustment
				-- for other layouts.
				letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

				-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
				-- where X is the buffer number. But only a static string is accepted here.
				no_name_title = "New Buffer",

			})
		end,
	},
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"smiteshp/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	-- { 'Bekaboo/dropbar.nvim' },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--ColorScheme                                      │
	--  ╰──────────────────────────────────────────────────────────╯
	-- { "rose-pine/neovim", name = "rose-pine" },
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "marko-cerovac/material.nvim" },
	-- {"tomasiser/vim-code-dark"},
	-- { "https://github.com/sainnhe/sonokai" },
	-- { "Mofiqul/vscode.nvim" },
	{ "Pocco81/HighStr.nvim" },
	{ "azabiong/vim-highlighter" },
	-- { "sunjon/shade.nvim" },
	-- { "folke/twilight.nvim",
	-- 	config = function()
	-- 		require("twilight").setup({
	-- 			-- your configuration comes here
	-- 			-- or leave it empty to h, default settings
	-- 			-- refer to the configuration section below
	-- 		})
	-- 	end,
	-- },
	-- { "navarasu/onedark.nvim" },
	-- { "olimorris/onedarkpro.nvim" },
	-- { "lunarvim/Onedarker.nvim" },
	{ "EdenEast/nightfox.nvim" },
	-- { "marko-cerovac/materialepllnvim" },
	-- { "ray-x/aurora" },
	-- { "ray-x/starry.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Telescope                                        │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		-- or                            , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- { "vanya-robertson/telescope-media-files.nvim" },
	{ "nvim-telescope/telescope-symbols.nvim" },
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release; cmake --build build --config Release'
	},
	-- { "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-lua/popup.nvim" },
	-- { "ThePrimeagen/git-worktree.nvim" },
	{ "ThePrimeagen/harpoon" },
	{ "nvim-telescope/telescope-dap.nvim" },
	-- { "gbrlsnchs/telescope-lsp-handlers.nvim" },
	-- { "lpoto/telescope-docker.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	-- {
	-- 	"jedrzejboczar/possession.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function ()
	-- 		require('possession').setup({})
	-- 	end
	-- },
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({})
		end,
	},
	-- {
	-- 	"3rd/image.nvim",
	-- 	dependencies = { "luarocks.nvim" },
	-- 	config = function()
	-- 		-- default config
	-- 		require("image").setup({
	-- 			backend = "kitty",
	-- 			integrations = {
	-- 				markdown = {
	-- 					enabled = true,
	-- 					clear_in_insert_mode = false,
	-- 					download_remote_images = true,
	-- 					only_render_image_at_cursor = false,
	-- 					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
	-- 				},
	-- 				neorg = {
	-- 					enabled = true,
	-- 					clear_in_insert_mode = false,
	-- 					download_remote_images = true,
	-- 					only_render_image_at_cursor = false,
	-- 					filetypes = { "norg" },
	-- 				},
	-- 			},
	-- 			max_width = nil,
	-- 			max_height = nil,
	-- 			max_width_window_percentage = nil,
	-- 			max_height_window_percentage = 50,
	-- 			window_overlap_clear_enabled = false,                         -- toggles images when windows are overlapped
	-- 			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	-- 			editor_only_render_when_focused = false,                      -- auto show/hide images when the editor gains/looses focus
	-- 			tmux_show_only_in_active_window = false,                      -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	-- 			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
	-- 		})
	-- 	end,
	-- },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--IndentBlankline/Fold                             │
	--  ╰──────────────────────────────────────────────────────────╯
	{ 
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function ()
			require("ibl").setup({
				indent = {
					tab_char = "▎",
					priority = 1,
				},
				whitespace = {
					highlight = { "Whitespace", "NonText" },
					remove_blankline_trail = true,
				},
				scope = {
					enabled = true,
					show_start = true,
					show_end = false,
					injected_languages = false,
					highlight = highlight,
					priority = 500,
				},
			})
		end
	},
	{ "e-roux/pretty-fold.nvim" },
	-- { "lukas-reineke/virt-column.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--NewScroll                                        │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{ "gen740/SmoothCursor.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Debugger                                           │
	--  ╰──────────────────────────────────────────────────────────╯
	-- {"puremourning/vimspector"},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Comment                                            │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "LudoPinelli/comment-box.nvim" },
	-- Lua
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {},
	},
	-- {
	-- 	"s1n7ax/nvim-comment-frame",
	-- 	dependencies = {
	-- 		{ "nvim-treesitter" },
	-- 	},
	-- 	config = function()
	-- 		require("nvim-comment-frame").setup()
	-- 	end,
	-- },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Neovim Ranger                                      │
	--  ╰──────────────────────────────────────────────────────────╯
	-- { "kevinhwang91/rnvimr" },
	{
		"DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Git Fungitive                                      │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "tpope/vim-fugitive" },
	{ "tveskag/nvim-blame-line" },
	{ 
		"f-person/git-blame.nvim",
		-- event = "VeryLazy",
		config = function ()
			require("gitblame").setup({})
		end,
		opts = {
			-- your configuration comes here
			-- for example
			enabled = true,  -- if you want to enable the plugin
			message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
		},
	},
	-- {
	-- 	"tanvirtin/vgit.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },
	-- { "rhysd/git-messenger.vim" },
	-- { "rbong/vim-flog" },
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		config = function()
			require("lazy").setup({
				-- optional for floating window border decoration
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
				-- setting the keybinding for LazyGit with 'keys' is recommended in
				-- order to load the plugin when the command is run for the first time
				keys = {
					{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
				},
			})
		end,
	},
	--  ╭───────────╮
	--  │ --Trouble │
	--  │    Lua    │
	--  ╰───────────╯
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function ()
			require("trouble").setup({})
		end
	},

	--  ╭─────────────────────╮
	--  │ Definitive git info │
	--  ╰─────────────────────╯
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Window animations                                │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"d7omdev/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},
	--  ╭────────╮
	--  │ Docker │
	--  ╰────────╯
	-- {
	-- 	'dgrbrady/nvim-docker',
	-- 	dependencies = {
	-- 		'nvim-lua/plenary.nvim',
	-- 		'MunifTanjim/nui.nvim'
	-- 	},
	-- },

	--  ╭─────────────────────────────────────────────────╮
	--  │      Themes Install without configuration       │
	--  ╰─────────────────────────────────────────────────╯
	{
		"craftzdog/solarized-osaka.nvim",
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- { "projekt0n/github-nvim-theme" },
	-- {
	-- 	"liuchengxu/vista.vim",
	-- 	config = function()
	-- 		vim.g["vista_icon_ident"] = '"╰─▸ ", "├─▸ "'
	-- 		vim.g["vista_default_executive"] = "ctags"
	-- 		vim.g["vista_fzf_preview"] = 'right:50%'
	-- 	end
	-- },

	--  ╭───────────────────────────╮
	--  │    Popup frames Packer    │
	--  ╰───────────────────────────╯
	{
		"folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to h, notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"mbbill/undotree",
	},
	{
		"udalov/kotlin-vim",
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		Translation                                          │
	--  ╰──────────────────────────────────────────────────────────╯
	-- { "aserowy/tmux.nvim" },
	-- {
	-- 	"https://git.sr.ht/~swaits/zellij-nav.nvim",
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left" } },
	-- 		{ "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
	-- 		{ "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
	-- 		{ "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
	-- 	},
	-- 	opts = {},
	-- },
}
