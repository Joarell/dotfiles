local M = {}

function M.setup()
	vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"
	local autocmd = vim.api.nvim_create_autocmd

	autocmd('BufReadPre', {
		group = vim.api.nvim_create_augroup("DBGroup", { clear = true }),
		pattern = "sql",
		command = [[setlocal omnifunc=vim_dadbod_compleetion#omin]],
	})

	autocmd("BufReadPre", {
		group = vim.api.nvim_create_augroup("DBFilesGroup", { clear = true }),
		pattern =  { "sql", "mysql", "plsql", },
		callback = function ()
			vim.schedule(db_completion)
		end,
	})
end


return M
