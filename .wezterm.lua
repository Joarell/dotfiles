-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

--  ╭───────────────────────────────────────────────────────────────╮
--  │  ╭──────────────────────────────────────────────────────────╮ │
--  │  │   This is where you actually apply your config choices   │ │
--  │  │         For example, changing the color scheme:          │ │
--  │  ╰──────────────────────────────────────────────────────────╯ │
--  ╰───────────────────────────────────────────────────────────────╯

config.color_scheme = 'Builtin Tango Dark'
-- config.color_scheme = 'Bleh-1 (terminal.sexy)'
-- config.color_scheme = 'Bespin (dark) (terminal.sexy)'
-- config.color_scheme = 'Belge (terminal.sexy)'
-- config.color_scheme = 'Atelierforest (dar) (terminal.sexy)'

config.window_background_opacity = .9
config.enable_wayland = true

config.enable_tab_bar = false

config.font = wezterm.font_with_fallback {
	'CaskaydiaCove NF',
}

config.font_rules = {
	--  ╭──────────────────────────────────────────────────────────╮
	--  │    For Bold-but-not-italic text, use this relatively     │
	--  │                 bold font, and override                  │
	--  │    its color to a tomato-red color to make bold text     │
	--  │                    really stand out.                     │
	--  ╰──────────────────────────────────────────────────────────╯
	{
		intensity = 'Bold',
		italic = false,
		font = wezterm.font_with_fallback {
			'CaskaydiaCove NF',
			-- Override the color specified by the terminal output and force
			-- it to be tomato-red.
			-- The color value you set here can be any CSS color name or
			-- RGB color string.
		},
	},

	-- Bold-and-italic
	{
		intensity = 'Bold',
		italic = true,
		font = wezterm.font_with_fallback {
			family = 'CaskaydiaCove NF',
			italic = true,
		},
	},

	-- normal-intensity-and-italic
	{
		intensity = 'Normal',
		italic = true,
		font = wezterm.font_with_fallback {
			family = 'CaskaydiaCove NF',
			weight = 'DemiLight',
			italic = true,
		},
	},

	-- half-intensity-and-italic (half-bright or dim); use a lighter weight font
	{
		intensity = 'Half',
		italic = true,
		font = wezterm.font_with_fallback {
			family = 'CaskaydiaCove NF',
			weight = 'Light',
			italic = true,
		},
	},

	-- half-intensity-and-not-italic
	{
		intensity = 'Half',
		italic = false,
		font = wezterm.font_with_fallback {
			family = 'CaskaydiaCove NF',
			weight = 'Light',
		},
	},
}

config.font_size = 11.0

config.cursor_blink_ease_in = {
	CubicBezier = { 0.0, 0.0, 0.58, 1.0 }
}
config.cursor_blink_ease_out = 'Linear'
config.cursor_blink_rate = 200

--  ╭──────────────────────────────────────────────────────────────────────╮
--  │ The following configuration enables a low intensity visual bell that │
--  │ takes a total of 300ms to "flash" the screen:                        │
--  ╰──────────────────────────────────────────────────────────────────────╯
config.visual_bell = {
	fade_in_function = 'EaseIn',
	fade_in_duration_ms = 150,
	fade_out_function = 'EaseOut',
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = '#202020',
}

-- and finally, return the configuration to wezterm
return config
