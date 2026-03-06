version = "1.1.0"

local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path

require('icons').setup()
require('fzf').setup()
require('nuke').setup()
require('nvim-ctrl').setup()
require('preview-tabbed').setup()
require('more_icons').setup()

xplr.config.general.disable_debug_error_mode = true
xplr.config.general.show_hidden = true
-- xplr.config.node_types.directory.style = { "Style" }
xplr.config.node_types.mime_essence = {
	application = {
		-- application/*
		["*"] = { meta = { icon = "a" } },

		-- application/pdf
		pdf = { meta = { icon = "" }, style = { fg = "Blue" } },

		-- application/zip
		zip = { meta = { icon = "" } },
	},
}

xplr.config.node_types.extension.md = { meta = { icon = "" }, style = { fg = "Blue" } }
xplr.config.node_types.extension.rs = { meta = { icon = "🦀" } }
