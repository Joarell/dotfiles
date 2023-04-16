--###########################################################################--
-- 							Packer Settings	 								 --
--###########################################################################--
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
local packer = require("packer")

packer.startup({
	function(use)
		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Faster starters                                  │
		--  ╰──────────────────────────────────────────────────────────╯
		-- use("nathom/filetype.nvim")

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		Discord app monitor                                │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "andweeb/presence.nvim" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		Packer can manage itself                           │
		--  ╰──────────────────────────────────────────────────────────╯
		use("wbthomason/packer.nvim")

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		icons                                              │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "nvim-tree/nvim-web-devicons" })

		-- You can specify multiple plugins in a single call
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		})
		use({ "nvim-treesitter/nvim-treesitter-context" })
		-- use({ "nvim-treesitter/playground" })
		use({ "nvim-treesitter/nvim-treesitter-refactor" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		You can alias plugin names                         │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "dracula/vim", as = "dracula" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Lua status line/column                           │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
		-- use({ "luukvbaal/statuscol.nvim" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--BufferLine                                       │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
		use({ "romgrk/barbar.nvim" })
		use({
			"utilyre/barbecue.nvim",
			requires = {
				"neovim/nvim-lspconfig",
				"smiteshp/nvim-navic",
				"nvim-tree/nvim-web-devicons", -- optional
			},
		})

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--ColorScheme                                      │
		--  ╰──────────────────────────────────────────────────────────╯
		use("tomasiser/vim-code-dark")
		use("norcalli/nvim-colorizer.lua")
		-- use({ "https://github.com/sainnhe/sonokai" })
		use({ "Mofiqul/vscode.nvim" })
		use({ "p00f/nvim-ts-rainbow" })
		use({ "Pocco81/HighStr.nvim" })
		use({ "azabiong/vim-highlighter" })
		use({ "chriskempson/base16-vim" })
		use({ "sunjon/shade.nvim" })
		use({
			"folke/twilight.nvim",
			config = function()
				require("twilight").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})
		-- use({ "roobert/tailwindcss-colorizer-cmp.nvim" })
		use({ "navarasu/onedark.nvim" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Telescope                                        │
		--  ╰──────────────────────────────────────────────────────────╯
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.1",
			-- or                            , branch = '0.1.x',
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use({ "nvim-telescope/telescope-media-files.nvim" })
		use({ "nvim-telescope/telescope-symbols.nvim" })
		-- use({ "nvim-lua/popup.nvim" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--IndentBlankline/Fold                             │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "lukas-reineke/indent-blankline.nvim" })
		use({ "anuvyklack/pretty-fold.nvim" })
		use({ "lukas-reineke/virt-column.nvim" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--NewScroll                                        │
		--  ╰──────────────────────────────────────────────────────────╯
		use("karb94/neoscroll.nvim")
		use({
			"gen740/SmoothCursor.nvim",
			config = function()
				require("smoothcursor").setup()
			end,
		})

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Debugger                                         │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "puremourning/vimspector" })
		use({ "michaelb/sniprun", run = "bash ./install.sh" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--LSP and autocomplitions.                         │
		--  ╰──────────────────────────────────────────────────────────╯
		-- use({'VonHeikemen/Lsp-zero.nvim', branch = 'v1.x'})
		use({
			"williamboman/mason.nvim",
			"williamboman/nvim-lsp-installer",
			"williamboman/mason-lspconfig.nvim",
			"kabouzeid/nvim-lspinstall",
		})
		-- use({ "dcampos/cmp-snippy" })
		-- use({ "dcampos/nvim-snippy" })
		-- use({ "quangnguyen30192/cmp-nvim-ultisnips" })
		-- use({ "SirVer/ultisnips" })
		-- use({ "hrsh7th/cmp-vsnip" })
		use({ "hrsh7th/cmp-cmdline" })
		use({ "hrsh7th/nvim-cmp" })
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-path" })
		use({ "saadparwaiz1/cmp_luasnip" })
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "L3MON4D3/LuaSnip", run = "make install_jsregexp", tag = "v<CurrentMajor>.*" })
		-- use({ "rafamadriz/friendly-snippets" })
		use({ "jose-elias-alvarez/null-ls.nvim" })
		use({ "windwp/nvim-ts-autotag" })
		use({ "jayp0521/mason-null-ls.nvim" })
		use({ "onsails/lspkind.nvim" })
		use({ "uga-rosa/cmp-dictionary" })
		-- use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
		use({ "shinglyu/vim-codespell" })
		use({
			"bennypowers/nvim-regexplainer",
			config = function()
				require("regexplainer").setup()
			end,
			requires = {
				"nvim-treesitter/nvim-treesitter",
				"MunifTanjim/nui.nvim",
			},
		})

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Comment                                          │
		--  ╰──────────────────────────────────────────────────────────╯
		use("LudoPinelli/comment-box.nvim")
		use("terrortylor/nvim-comment")
		-- Lua
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})
		use({
			"s1n7ax/nvim-comment-frame",
			requires = {
				{ "nvim-treesitter" },
			},
			config = function()
				require("nvim-comment-frame").setup()
			end,
		})

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Neovim Ranger                                    │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "kevinhwang91/rnvimr" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Git Fungitive                                    │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "tpope/vim-fugitive" })
		use({ "tveskag/nvim-blame-line" })
		use({
			"tanvirtin/vgit.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		use({ "rhysd/git-messenger.vim" })
		use({ "rbong/vim-flog" })

		--  ╭───────────╮
		--  │ --Trouble │
		--  │    Lua    │
		--  ╰───────────╯
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})

		--HTML and CSS autopairs.
		-- use({
		-- 	"windwp/nvim-autopairs",
		-- 	config = function()
		-- 		require("nvim-autopairs").setup({
		-- 			disable_filetype = { "TelescopePrompt", "vim" },
		-- 		})
		-- 	end,
		-- })

		--  ╭─────────────────────╮
		--  │ Definitive git info │
		--  ╰─────────────────────╯
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
		use({ "preservim/tagbar" })

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		--Window animations                                │
		--  ╰──────────────────────────────────────────────────────────╯
		use({
			"anuvyklack/windows.nvim",
			requires = {
				"anuvyklack/middleclass",
				"anuvyklack/animation.nvim",
			},
			config = function()
				vim.o.winwidth = 10
				vim.o.winminwidth = 10
				vim.o.equalalways = false
				require("windows").setup()
			end,
		})

		--  ╭─────────────────────────╮
		--  │ DB connections/settings │
		--  ╰─────────────────────────╯
		-- use({'mzarnitsa/psql'})

		--  ╭───────────────────────────────╮
		--  │            Themes             │
		--  │ Install without configuration │
		--  ╰───────────────────────────────╯
		use({ "projekt0n/github-nvim-theme" })
		use({ "liuchengxu/vista.vim" })

		--  ╭──────────────╮
		--  │ Pupup frames │
		--  │    Packer    │
		--  ╰──────────────╯
		use({
			"folke/noice.nvim",
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
			},
		})

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 		Translation                                        │
		--  ╰──────────────────────────────────────────────────────────╯
		use({ "potamides/pantran.nvim" })
		use({
			"aserowy/tmux.nvim",
			config = function()
				require("tmux").setup()
			end,
		})

		--  ╭──────────────────────────────────────────────────────────╮
		--  │ 	This is the float settgin to open packer:              │
		--  ╰──────────────────────────────────────────────────────────╯
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
