return {
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		opt = true,
		config = function ()
			require("config.dadbod").setup()
		end
	},
}
