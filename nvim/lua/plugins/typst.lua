return {
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "0.1.*",
		dependencies = {
			"kaarmu/typst.vim",
			ft = "typst",
			lazy = false,
		},
	},
	{
		"arminveres/md-pdf.nvim",
		branch = "main", -- you can assume that main is somewhat stable until releases will be made
		lazy = false,
		keys = {
			{
				"<leader>,",
				function()
					require("md-pdf").convert_md_to_pdf()
				end,
				desc = "Markdown preview",
			},
		},
		opts = {},
		config = function()
			require("md-pdf").setup({
				--- Set margins around document
				margins = "1.5cm",
				--- tango, pygments are quite nice for white on white
				highlight = "tango",
				--- Generate a table of contents, on by default
				toc = true,
				--- Define a custom preview command, enabling hooks and other custom logic
				preview_cmd = function()
					-- return "firefox-developer-edition"
					return "okular"
				end,
			})
		end,
	},
}
