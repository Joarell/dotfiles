require("dapui").setup({})
local dap = require("dap")
local dapui = require("dapui")

-- dapui.float_element()
-- dapui.eval()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end


dap.adapters.node2 = {
	type = "executable",
	command = "node-debug2-adapter",
	args = {},
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "launch",
	},
}

dapui.setup({
	layouts = {{
		elements = {{
			id = "scopes",
			size = 0.25
		},{
			id = "breakpoints",
			size = 0.25
		},{
			id = "stacks",
			size = 0.25
		},{
			id = "watches",
			size = 0.25
		}},
		position = "left",
			size = 80
		},{
		elements = {{
			id = "repl",
			size = 0.2,
		 },{
			id = "console",
			size = 0.5,
		 }},
		position = "bottom",
		size = 5
	}}
})
