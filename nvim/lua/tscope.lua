--###########################################################################--
-- 					Telescope Settings		 								 --
--###########################################################################--
-- require("telescope").load_extension("media_files")
require("telescope").load_extension("noice")
require("telescope").load_extension("notify")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("git_worktree")
local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
telescope.setup {
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
			search_dirs = { "." },
		},
		colorscheme = {
			enable_preview = true,
		},
	},
	defaults = {
		-- selection_caret = " ",
		selection_caret = " ",
		prompt_prefix = "  ",
		initial_mode = "normal",
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
}

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")
local opts = { silent = true, noremap = true }

keymap("n", "ts", function()
	builtin.colorscheme({ enable_preview = true })
end, opts)
keymap("n", "fz", builtin.find_files, opts)
keymap("n", "fg", builtin.live_grep, opts)
keymap("n", "fb", builtin.buffers, opts)
keymap("n", "fh", builtin.help_tags, opts)
keymap("n", "tt", ":Telescope<CR>", opts)
keymap("n", "tk", ":Telescope keymaps<CR>", opts)
-- keymap("n", "tm", ":Telescope media_files<CR>", opts)
keymap("n", "tn", ":Telescope notify<CR>", opts)
keymap("n", "to", ":Telescope oldfiles<CR>", opts)
keymap("n", "th", builtin.help_tags, opts)
keymap("n", "tb", ":Telescope file_browser<CR>", opts)
keymap("n", "tm", ":Telescope harpoon marks<CR>", opts)
