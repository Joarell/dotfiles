--  ╭──────────────────────────────────────────────────────────╮
--  │                      Lazy Settings.                      │
--  ╰──────────────────────────────────────────────────────────╯

return {
	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		Discord app monitor                                │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "andweeb/presence.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		icons                                              │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "nvim-tree/nvim-web-devicons" },

	-- You can specify multiple plugins in a single call
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	-- { "nvim-treesitter/playground" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Lua status line/column                           │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			opt = true
		}
	},
	-- { "luukvbaal/statuscol.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--BufferLine                                       │
	--  ╰──────────────────────────────────────────────────────────╯
	-- { "akinsho/bufferline.nvim", tag = "v2.*", dependenciess = "nvim-tree/nvim-web-devicons" },
	{ "romgrk/barbar.nvim" },
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
	{"tomasiser/vim-code-dark"},
	-- { "https://github.com/sainnhe/sonokai" },
	{ "Mofiqul/vscode.nvim" },
	{ "p00f/nvim-ts-rainbow" },
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
	{ "olimorris/onedarkpro.nvim" },
	{ "lunarvim/Onedarker.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "marko-cerovac/material.nvim" },
	{ "ray-x/aurora" },
	{ "ray-x/starry.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Telescope                                        │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
	},
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "nvim-telescope/telescope-symbols.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-lua/popup.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--IndentBlankline/Fold                             │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "anuvyklack/pretty-fold.nvim" },
	{ "lukas-reineke/virt-column.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--NewScroll                                        │
	--  ╰──────────────────────────────────────────────────────────╯
	{"karb94/neoscroll.nvim"},
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup()
		end,
	},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Debugger                                         │
	--  ╰──────────────────────────────────────────────────────────╯
	-- {"puremourning/vimspector"},

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Comment                                          │
	--  ╰──────────────────────────────────────────────────────────╯
	{"LudoPinelli/comment-box.nvim"},
	{"terrortylor/nvim-comment"},
	-- Lua
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to h, default settings
				-- refer to the configuration section below
			})
		end,
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
	--  │ 		--Neovim Ranger                                    │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "kevinhwang91/rnvimr" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Git Fungitive                                    │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "tpope/vim-fugitive" },
	{ "tveskag/nvim-blame-line" },
	{
		"tanvirtin/vgit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
	},
	{ "rhysd/git-messenger.vim" },
	-- { "rbong/vim-flog" },

	--  ╭───────────╮
	--  │ --Trouble │
	--  │    Lua    │
	--  ╰───────────╯
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	--HTML and CSS autopairs.
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	config = function()
	-- 		dependencies("nvim-autopairs").setup({
	-- 			disable_filetype = { "TelescopePrompt", "vim" },
	-- 		})
	-- 	end,
	-- },

	--  ╭─────────────────────╮
	--  │ Definitive git info │
	--  ╰─────────────────────╯
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		--Window animations                                │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		"anuvyklack/windows.nvim",
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

	--  ╭─────────────────────────╮
	--  │ DB connections/settings │
	--  ╰─────────────────────────╯
	-- {'mzarnitsa/psql'},

	--  ╭─────────────────────────────────────────────────╮
	--  │      Themes Install without configuration       │
	--  ╰─────────────────────────────────────────────────╯
	-- { "projekt0n/github-nvim-theme" },
	{
		"liuchengxu/vista.vim",
		config = function()
			vim.g["vista_icon_ident"] = '"╰─▸ ", "├─▸ "'
			vim.g["vista_default_executive"] = "ctags"
			vim.g["vista_fzf_preview"] = 'right:50%'
		end
	},

	--  ╭───────────────────────────╮
	--  │    Pupup frames Packer    │
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

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ 		Translation                                        │
	--  ╰──────────────────────────────────────────────────────────╯
	{ "aserowy/tmux.nvim"},
}
