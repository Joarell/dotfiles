--  ╭──────────────────────────────────────────────────────────╮
--  │                   Telescope Settings.                    │
--  ╰──────────────────────────────────────────────────────────╯
require("telescope").load_extension("ui-select")
require("telescope").load_extension("noice")
require("telescope").load_extension("notify")
require("telescope").load_extension("remote-sshfs")
-- require("telescope").load_extension("file_browser")
-- require("telescope").load_extension("git_worktree")
require("telescope").load_extension("dap")
-- require("telescope").load_extension("docker")
-- require("telescope").load_extension("media_files")

local ok = pcall(require, "harppon")
if ok then
	require("telescope").load_extension("harpoon")
end

local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope").open
local connections = require("remote-sshfs.connections")
local ssh_api = require('remote-sshfs.api')

telescope.setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}), },
		docker = {
			theme = "dropdown",
			binary = "docker",
			compose_binary = "docker compose",
		},
		file_browser = {
			theme = "dropdown",
		},
		media_files = {
			filetypes = {
				"png",
				"webp",
				"jpg",
				"jpeg",
				"pdf",
				"epub"
			},
			find_cmd = "rg",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
			search_dirs = { "." },
			-- theme = "dropdown",
		},
		live_grep = {
			-- theme = "dropdown",
		},
		colorscheme = {
			enable_preview = true,
			theme = "dropdown",
		},
		oldfiles = {
			-- theme = "dropdown",
		},
	},
	defaults = {
		-- selection_caret = " ",
		selection_caret = " ",
		prompt_prefix = "  ",
		initial_mode = "normal",
		mappings = {
			i = { ["<C-t>"] = trouble },
			n = { ["<C-t>"] = trouble },
		},
	},
	mappings = {
		i = {
			["<C-Down>"] = actions.cycle_history_next,
			["<C-Up>"] = actions.cycle_history_prev,
		},
	},
})

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")
local opts = { silent = true, noremap = true }

keymap("n", "QF", builtin.quickfix, opts)
keymap("n", "FH", builtin.quickfixhistory, opts)
keymap("n", "ts", builtin.colorscheme, opts)
-- keymap("n", "fz", builtin.find_files, opts)
-- keymap("n", "lg", builtin.live_grep, opts)
keymap("n", "fb", builtin.buffers, opts)
keymap("n", "fh", builtin.help_tags, opts)
keymap("n", "tt", ":Telescope<CR>", opts)
keymap("n", "tk", ":Telescope keymaps<CR>", opts)
keymap("n", "TM", ":Telescope media_files<CR>", opts)
keymap("n", "tn", ":Telescope notify<CR>", opts)
keymap("n", "to", ":Telescope oldfiles<CR>", opts)
keymap("n", "th", builtin.help_tags, opts)
keymap("n", "gd", builtin.lsp_definitions, opts)
keymap("n", "gr", builtin.lsp_references, opts)
keymap("n", "td", builtin.lsp_type_definitions, opts)
keymap("n", "tb", ":Telescope file_browser<CR>", opts)
keymap("n", "tm", ":Telescope harpoon marks<CR>", opts)
keymap("n", "fz", function ()
	if connections.is_connected() then
		ssh_api.find_files()
	else
		builtin.find_files()
	end
end, opts)
keymap("n", "lg", function ()
	if connections.is_connected() then
		ssh_api.find_files()
	else
		builtin.live_grep()
	end
end, opts)

local ssh = vim.api.nvim_create_augroup("SSH", {})
vim.api.nvim_create_autocmd("BufLeave", {
	callback = function ()
		if connections.is_connected() then
			ssh_api.disconnect()
			vim.notify("SSH DISCONNTED! 🔌", 3, {})
		end
	end,
	group = ssh,
})
