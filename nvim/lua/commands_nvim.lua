
local bufnr = vim.api.nvim_get_current_buf()
local session = 0

-- Incomplete commands at the moment. It's intent to virtualize tests status.
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("TestRunner", { clear = true }),
	pattern = { "*.test.js", "*.test.mjs" },
	callback = function()
		print("Test successful run!")
		local file = vim.fn.expand("%")
		-- vim.cmd( "!node --test " .. file .. " > test")
		vim.fn.jobstart({ "node", "--test", file },
		{
			stdout_buffered = true,
			on_stdout = function (_, data)
				if not data then
					return
				end
				if data then
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
				end
				if session == 0 then
					vim.cmd.vsplit()
					session = 1
					vim.cmd('BufferNext')
				end
				local count = 0
				local result = {}
				local info = string.format(vim.inspect(data))
				for i in string.gmatch(info, "\"%a+") do
					print(i)
					table.insert(result, i)
				end
				-- for val in pairs(result) do
				-- 	print(val)
				-- end
			end,
			on_stderr = function (_, data)
				if data then
					vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
				end
			end
		})
	end,
})
