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

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/home/jev/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/",
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}

-- dap.adapters.gdb = {
-- 	type = "executable",
-- 	command = "gdb",
-- 	args = { "-i", "dap" },
-- }

-- dap.configurations.rust = {
-- 	{
-- 		name = "Launch",
-- 		type = "gdb",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 	},
-- }

-- dap.configurations.cpp = {
-- 	{
-- 		name = "Launch",
-- 		type = "gdb",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 	},
-- }

-- dap.configurations.c = {
-- 	{
-- 		name = "Launch",
-- 		type = "gdb",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 	},
-- }

-- dapui.setup({
-- 	layouts = {
-- 		{
-- 			elements = {
-- 				{
-- 					id = "scopes",
-- 					size = 0.25,
-- 				},
-- 				{
-- 					id = "breakpoints",
-- 					size = 0.25,
-- 				},
-- 				{
-- 					id = "stacks",
-- 					size = 0.25,
-- 				},
-- 				{
-- 					id = "watches",
-- 					size = 0.25,
-- 				},
-- 			},
-- 			position = "left",
-- 			size = 80,
-- 		},
-- 		{
-- 			elements = { {
-- 				id = "repl",
-- 				size = 0.2,
-- 				enabled = false,
-- 			}, {
-- 				id = "console",
-- 				size = 0.5,
-- 				enabled = false,
-- 			} },
-- 			position = "bottom",
-- 			size = 5,
-- 		},
-- 	},
-- })
