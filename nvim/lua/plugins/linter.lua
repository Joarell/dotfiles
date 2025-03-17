
return {
	{
		"mfussenegger/nvim-lint",
		config = function ()
			vim.env.ESLINT_D_PPID = vim.fn.getpid()
			require("lint").linters_by_ft = {
				markdown = { 'vale' },
				javascript = { 'eslint_d' },
				typescript = { 'eslint_d' },
			}
		end
	}
}
