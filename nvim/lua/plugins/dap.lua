--  ╭──────────────────────────────────────────────────────────╮
--  │                      DAP installer.                      │
--  ╰──────────────────────────────────────────────────────────╯
return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function ()
			require("nvim-dap-virtual-text").setup()
		end
	},
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	config = function ()
	-- 		local rt = require("rust-tools")
	--
	-- 		rt.setup({
	-- 			tools = {
	-- 				inlay_hints = { 
	-- 					auto = true,
	-- 					only_current_line = false,
	-- 					show_parameter_hints = true,
	-- 					parameter_hints_prefix = '<- ',
	-- 					other_hints_prefix = "-> ",
	-- 					max_len_align = false,
	-- 					max_len_align_padding = 1,
	-- 					right_align = false,
	-- 					right_align_padding = 7,
	-- 					highlight = "Comment",
	-- 				}
	-- 			},
	-- 			server = {
	-- 				standalone = true
	-- 			},
	-- 			dap = {
	-- 				adapter = {
	-- 					type = "executable",
	-- 					command = "lldb-vscode",
	-- 					name = "rt_lldb",
	-- 				}
	-- 			},
	-- 		})
	-- 	end
	-- },
}
