
--  ╭──────────────────────────────────────────────────────────╮
--  │ 		--Tailwind settings                                │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"NvChad/nvim-colorizer.lua",
		-- "lewis6991/nvim-colorizer.lua",
		config = function ()
			require('colorizer').setup({})
		end
	},
}
