--###########################################################################--
-- 					Telescop Settings		 								 --
--###########################################################################--
require("telescope").load_extension("media_files")
require("telescope").load_extension("notify")
require("telescope").setup({
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
			search_dirs = {"."},
		}
	},
	defaults = {
		selection_caret = " ",
		prompt_prefix = " ",
		initial_mode = "insert",
	}
})

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")
local opts = { silent = true, noremap = true }

keymap("n", "ff", builtin.find_files, opts)
keymap("n", "tc", builtin.colorscheme, opts)
keymap("n", "fg", builtin.live_grep, opts)
keymap("n", "fb", builtin.buffers, opts)
keymap("n", "fh", builtin.help_tags, opts)
keymap("n", "tt", ":Telescope<CR>", opts)
keymap("n", "tk", ":Telescope keymaps<CR>", opts)
keymap("n", "tm", ":Telescope media_files<CR>", opts)
keymap("n", "tn", ":Telescope notify<CR>", opts)
keymap("n", "to", ":Telescope oldfiles<CR>", opts)

