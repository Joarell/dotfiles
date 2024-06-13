--  ╭──────────────────────────────────────────────────────────╮
--  │                      DAP installer.                      │
--  ╰──────────────────────────────────────────────────────────╯
return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function ()
			require("nvim-dap-virtual-text").setup()
		end
	},
}
