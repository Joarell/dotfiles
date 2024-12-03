# Nushell Environment Config File
#
# version = "0.96.0"

def create_left_prompt [] {
	mut home = ""
		try {
			if $nu.os-info.name == "windows" {
				$home = $env.USERPROFILE
			} else {
				$home = $env.HOME
			}
		}

	let dir = ([
			($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
			($env.PWD | str substring ($home | str length)..)
	] | str join)

		let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
		let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
		let path_segment = $"($path_color)($dir)"

		$path_segment | str replace --all (char path_sep) $"($separator_color)/($path_color)"
}

def create_right_prompt [] {
# create a right prompt in magenta with green separators and am/pm underlined
	let time_segment = ([
			(ansi reset)
			(ansi magenta)
			(date now | format date '%Y/%m/%d %r')
	] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
	str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

		let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
				(ansi rb)
				($env.LAST_EXIT_CODE)
		] | str join)
		} else { "" }
	([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "$ " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| ": " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace/
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

$env.EDITOR = 'nvim'
$env.NUPM_HOME = '~/nupm/nupm/'
$env.NUPM_HOME = ($env.NUPM_HOME | path join "nupm")
$env.NU_LIB_DIRS = [
    ...
    ($env.NUPM_HOME | path join "modules")
]


# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
	"PATH": {
from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
	"Path": {
from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
# ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
# ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.PATH = ($env.PATH | split row (char esep) | append '~/nvim-discord/target/release/nvim-discord')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.moon/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.config/mise/config.toml')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.cargo/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.local/share/mise/installs/node/latest/bin')

neofetch
source ~/.zoxide.nu
ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -i -r -d | load-env
ssh-add ~/.ssh/id_jev
oh-my-posh init nu --config ~/oh-my-posh/themes/di4am0nd.omp.json
source ~/dotfiles/script.nu
source ~/.local/share/atuin/init.nu

$env.ANDROID_HOME = '~/Android/Sdk/'
$env.NU_PLUGIN_HIGHLIGHT_TRUE_COLORS = true


export-env {
	$env.MISE_SHELL = "nu"
	let mise_hook = {
		condition: { "MISE_SHELL" in $env }
		code: { mise_hook }
	}
	add-hook hooks.pre_prompt $mise_hook
	add-hook hooks.env_change.PWD $mise_hook
}

def --env add-hook [field: cell-path new_hook: any] {
	let old_config = $env.config? | default {}
	let old_hooks = $old_config | get $field --ignore-errors | default []
	$env.config = ($old_config | upsert $field ($old_hooks ++ $new_hook))
}

def "parse vars" [] {
	$in | from csv --noheaders --no-infer | rename 'op' 'name' 'value'
}

export def --env --wrapped main [command?: string, --help, ...rest: string] {
	let commands = ["deactivate", "shell", "sh"]

	if ($command == null) {
		^"/usr/bin/mise"
	} else if ($command == "activate") {
		$env.MISE_SHELL = "nu"
	} else if ($command in $commands) {
		^"/usr/bin/mise" $command ...$rest
		| parse vars
		| update-env
	} else {
		^"/usr/bin/mise" $command ...$rest
	}
}

def --env "update-env" [] {
	for $var in $in {
		if $var.op == "set" {
			load-env {($var.name): $var.value}
		} else if $var.op == "hide" {
			hide-env $var.name
		}
	}
}

def --env mise_hook [] {
	^"/usr/bin/mise" hook-env -s nu
	| parse vars
	| update-env
}
