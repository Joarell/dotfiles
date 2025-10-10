return {
	{
		"cordx56/rustowl",
		version = "*", -- Latest stable version
		build = "cargo binstall rustowl",
		lazy = false, -- This plugin is already lazy
		-- opts = {
		-- 	auto_enable = true,
		-- 	idle_time = 300,
		-- 	highlight_style = 'underline',
		-- 	client = {
		-- 		on_attach = function(_, buffer)
		-- 			print('attached', buffer)
		-- 			vim.keymap.set('n', '<leader>o', function()
		-- 				require('rustowl').toggle(buffer)
		-- 			end, { buffer = buffer, desc = 'Toggle RustOwl' })
		--
		-- 			vim.keymap.set('n', '<leader>re', function()
		-- 				require('rustowl').enable(buffer)
		-- 			end, { buffer = buffer, desc = 'Enable RustOwl' })
		--
		-- 			vim.keymap.set('n', '<leader>rd', function()
		-- 				require('rustowl').disable(buffer)
		-- 			end, { buffer = buffer, desc = 'Disable RustOwl' })
		-- 		end
		-- 	},
		-- 	colors = {
		-- 		colors = {
		-- 			lifetime = '#50fa7b',   -- Dracula green
		-- 			imm_borrow = '#8be9fd', -- Dracula cyan
		-- 			mut_borrow = '#ff79c6', -- Dracula pink
		-- 			move = '#f1fa8c',       -- Dracula yellow
		-- 			call = '#ffb86c',       -- Dracula orange
		-- 			outlive = '#ff5555',    -- Dracula red
		-- 		},
		-- 	},
		-- },
	}
}
