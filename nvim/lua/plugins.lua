-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	--Faster starters
	use("nathom/filetype.nvim")

	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- icons
	use({ "nvim-tree/nvim-web-devicons" })

	-- You can specify multiple plugins in a single call
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({ "nvim-treesitter/nvim-treesitter-context" })
	use({ "nvim-treesitter/playground" })

	-- You can alias plugin names
	use({ "dracula/vim", as = "dracula" })

	--Lua status line
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	--BufferLine
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

	--ColorScheme
	use("tomasiser/vim-code-dark")
	use("norcalli/nvim-colorizer.lua")
	use({ "https://github.com/sainnhe/sonokai" })
	use({ "Mofiqul/vscode.nvim" })
	use({ "p00f/nvim-ts-rainbow" })
	use({ "Pocco81/HighStr.nvim" })
	use({ "azabiong/vim-highlighter" })
	use({ "chriskempson/base16-vim" })

	--Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-media-files.nvim" })

	--IndentBlankline
	use({ "lukas-reineke/indent-blankline.nvim" })

	--NewScroll
	use("karb94/neoscroll.nvim")

	--Debugger
	use("puremourning/vimspector")

	--Explorer
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	--LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/nvim-lsp-installer",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({ "windwp/nvim-ts-autotag" })

	--Comment
	use("terrortylor/nvim-comment")

	--Neovim Ranger
	use({ "kevinhwang91/rnvimr" })

	--Git Fungitive
	use({ "tpope/vim-fugitive" })
	use({ "tveskag/nvim-blame-line" })
	use({
		"tanvirtin/vgit.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({ "rhysd/git-messenger.vim" })

	--AutoComplition
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })

	--Trouble
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	--HTML and CSS autopairs.
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	})
	use({ "shime/vim-livedown" })

	-- Definitive git info
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "preservim/tagbar" })
end)
