--                              ╭─────────────────╮
--                              │ Cursor settings │
--                              ╰─────────────────╯

require('smoothcursor').setup({
	autostart = true,
	cursor = "",       -- cursor shape (need nerd font)
	texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
	linehl = nil,         -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
	type = "matrix",     -- define cursor movement calculate function, "default" or "exp" (exponential).
	fancy = {
		enable = true,    -- enable fancy mode
		-- head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
		-- head = { cursor = "󰛓", texthl = "SmoothCursor", linehl = nil },
		-- head = { cursor = "󰞷", texthl = "SmoothCursor", linehl = nil },
		head = {
			cursor = require('smoothcursor.matrix_chars'),
			texthl = "SmoothCursor",
			linehl = nil },
		body = {
			length  = 30,
			cursor = require('smoothcursor.matrix_chars'),
			texthl = "SmoothCursorGreen",
		},
		tail = { cursor = nil, texthl = "SmoothCursor" },
		unstop = false
	},
	flyin_effect = nil,     -- "bottom" or "top"
	speed = 5,             -- max is 100 to stick to your current position
	intervals = 55,         -- tick interval
	priority = 1,          -- set marker priority
	timeout = 6000,         -- timout for animation
	threshold = 3,          -- animate if threshold lines jump
	disable_float_win = false, -- disable on float window
	enabled_filetypes = nil, -- example: { "lua", "vim" }
	disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
})

local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'ModeChanged' }, {
	callback = function()
		local current_mode = vim.fn.mode()
		if current_mode == 'n' then
			vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#00ffaa' })
			vim.fn.sign_define('smoothcursor', { text = '' })
			-- vim.fn.sign_define('smoothcursor', { text = '󰆤' })
			-- vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
			-- vim.fn.sign_define('smoothcursor', { text = '' })
		elseif current_mode == 'v' then
			vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
			vim.fn.sign_define('smoothcursor', { text = '󰧁' })
		elseif current_mode == 'V' then
			vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
			vim.fn.sign_define('smoothcursor', { text = '󰧈' })
		elseif current_mode == '�' then
			vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
			vim.fn.sign_define('smoothcursor', { text = '' })
		elseif current_mode == 'i' then
			vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
			vim.fn.sign_define('smoothcursor', { text = '󰗧' })
		end
	end,
})
