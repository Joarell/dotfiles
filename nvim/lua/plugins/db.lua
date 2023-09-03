return {
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
		},
		opt = true,
		config = function ()
			require("config.dadbod").setup()
		end
	},
}
