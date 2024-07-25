local session = 0

--- Incomplete commands at the moment. It's intent to virtualize tests status.
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("TestRunner", { clear = true }),
	pattern = { "*.test.js", "*.test.mjs" },
	callback = function()
		print("Test successful run!")
		local file = vim.fn.expand("%")
		vim.fn.jobstart({ "node", "--test", file },
		{
			stdout_buffered = true,
			on_stdout = function (_, data)
				if not data then
					return
				end
				if session == 0 then
					NEWBUF = vim.api.nvim_create_buf({}, {})
				end
				vim.api.nvim_buf_set_lines(NEWBUF, 0, -1, false, data)
				if session == 0 then
					vim.cmd.vsplit()
					session = 1
					vim.cmd('BufferNext')
				end
			end,
			on_stderr = function (_, data)
				if data then
					vim.api.nvim_buf_set_lines(NEWBUF, -1, -1, false, data)
				end
			end
		})
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("Transpiler", { clear = true }),
	pattern = { "*.ts" },
	callback = function()
		print("Transpiled! 😎")
		local file = vim.fn.expand("%")

		vim.fn.jobstart({ "tsc", file})
	end,
})
