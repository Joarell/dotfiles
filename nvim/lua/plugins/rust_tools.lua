return {
	"simrat39/rust-tools.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local rt = require("rust-tools")

		rt.setup({
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
			runnables = {
				use_telescope = true,
			},
			tools = {
				inlay_hints = {
					auto = true,
					show_parameter_hints = false,
					parameter_hints_prefix = "",
					other_hints_prefix = "",
				},
			},
		})
	end,
}
