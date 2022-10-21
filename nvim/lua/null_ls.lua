
--###########################################################################--
--						Diagnostics Settings								 --
--###########################################################################--
local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.eslint,
	-------------------------------------
	null_ls.builtins.diagnostics.eslint,
	-------------------------------------
	null_ls.builtins.completion.spell,
	null_ls.builtins.completion.vsnip,
	-------------------------------------
	null_ls.builtins.code_actions.eslint,
	-------------------------------------
	-- null_ls.builtins.hover,
}

null_ls.setup({ sources = sources })
