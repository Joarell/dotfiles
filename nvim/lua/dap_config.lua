require("dapui").setup({})
local dap = require("dap")
local dapui = require("dapui")

-- dapui.float_element()
-- dapui.eval()

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = "#FC007A" })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = "#00FF00" })
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { ctermbg = 0, fg = "#00CADD" })
vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { ctermbg = 0, fg = "#800080" })

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󱫪 ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })

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

dap.configurations.typescript = {
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
		name = "Attach",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "launch",
	},
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
		name = "Attach",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "launch",
	},
}

-- dap.adapters.cppdbg = {
-- 	id = "cppdbg",
-- 	type = "executable",
-- 	command = "/home/jev/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/",
-- }

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

vim.g.rustaceanvim = function()
	-- Update this path
	local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb"
	local this_os = vim.uv.os_uname().sysname

	-- The path is different on Windows
	if this_os:find("Windows") then
		codelldb_path = extension_path .. "adapter\\codelldb.exe"
		liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
	else
		-- The liblldb extension is .so for Linux and .dylib for MacOS
		liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
	end

	local cfg = require("rustaceanvim.config")
	return {
		dap = {
			adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	}
end

-- dap.adapters.gdb = {
-- 	type = "executable",
-- 	command = "gdb",
-- 	args = { "-i", "dap" },
-- }


local mason_registry = require("mason-registry")
-- local codelldb = mason_registry.get_package("codelldb")
-- local extension_path = codelldb:get_install_path() .. "/extension/"
-- local codelldb_path = extension_path .. "adapter/codelldb"

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" }
	}
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
