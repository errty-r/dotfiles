# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_xrat_global_optspecs
	string join \n v/verbose q/quiet database= config= xray= v2ray= sing-box= h/help V/version
end

function __fish_xrat_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_xrat_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_xrat_using_subcommand
	set -l cmd (__fish_xrat_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c xrat -n "__fish_xrat_needs_command" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_needs_command" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_needs_command" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_needs_command" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_needs_command" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_needs_command" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_needs_command" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_needs_command" -s V -l version -d 'Print version'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "init" -d 'Initialize config directory, config file, and database.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "setup" -d 'Run post-install setup: proxy cores, init, daemon, completions, man pages, and desktop integration.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "install" -d 'Install Xray, V2Ray, or sing-box from its upstream release repository.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "import" -d 'Import a subscription URL, file, or raw text into SQLite.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "add" -d 'Add a single config URI directly to SQLite.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "list" -d 'List stored configs or subscriptions.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "show" -d 'Show details for a config or subscription.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "enable" -d 'Enable a config.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "disable" -d 'Disable a config.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "delete" -d 'Delete a config (soft/hard) or a subscription with its configs.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "restore" -d 'Restore a soft-deleted config.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "purge" -d 'Permanently delete all soft-deleted configs.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "test" -d 'Test connectivity and latency for stored configs.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "scan" -d 'Scan candidate IPs for TCP reachability and persist results.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "connect" -d 'Start a managed proxy runtime for a stored config.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "disconnect" -d 'Stop the active managed proxy runtime.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "status" -d 'Show the managed proxy runtime status.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "logs" -d 'Show app events plus xray-core / sing-box engine logs.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "daemon" -d 'Run or control the XRAT daemon supervisor process.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "db" -d 'Inspect and maintain the XRAT database.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "rotate" -d 'Control automatic proxy rotation scheduling via the daemon.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "proxy" -d 'Local proxy endpoints and host/session integration helpers.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "serve" -d 'Start the local Axum HTTP API server.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "tui" -d 'Start the interactive terminal UI.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "tun" -d 'Prepare and inspect system privileges for managed TUN capture.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "update" -d 'Refresh stored subscriptions.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "parse" -d 'Parse and validate config links without persisting.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "validate" -d 'Validate an XRAT config.toml file.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "upgrade" -d 'Self-upgrade xrat from the latest release or by building from source.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "version" -d 'Print the xrat version.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "mmdb" -d 'Inspect and manage GeoLite2 MMDB assets.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "manpage" -d 'Generate man pages for xrat and all subcommands.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "completions" -d 'Generate shell completion scripts for xrat.'
complete -c xrat -n "__fish_xrat_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand init" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand init" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand init" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand init" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand init" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand init" -l dry-run -d 'Print planned actions without creating any files'
complete -c xrat -n "__fish_xrat_using_subcommand init" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand init" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand init" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l format -d 'Output format for --check' -r -f -a "table\t''
json\t''"
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand setup" -s y -l yes -d 'Accept all recommended defaults without prompting'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l no-daemon -d 'Do not install or start the background daemon'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l no-desktop -d 'Skip the desktop launcher and icon install (Linux/XDG only)'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l no-completions -d 'Skip installing shell completions'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l no-manpages -d 'Skip installing man pages'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l linger -d 'Enable boot-before-login start (Linux; implies installing the daemon)'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -l check -d 'Diagnose only: report what is and is not set up, changing nothing'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand setup" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand install" -l version -d 'Release version to install. Defaults to the latest stable release' -r
complete -c xrat -n "__fish_xrat_using_subcommand install" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand install" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand install" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand install" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand install" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand install" -l prerelease -d 'Install the newest published prerelease instead of the latest stable release'
complete -c xrat -n "__fish_xrat_using_subcommand install" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand install" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand install" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand import" -s n -l name -d 'Name for the imported subscription source.' -r
complete -c xrat -n "__fish_xrat_using_subcommand import" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand import" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand import" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand import" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand import" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand import" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand import" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand import" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand add" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand add" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand add" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand add" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand add" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand add" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand add" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand add" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -f -a "configs" -d 'List stored nodes/configs.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -f -a "subscriptions" -d 'List stored subscriptions.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and not __fish_seen_subcommand_from configs subscriptions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l subscription -d 'Show only configs from the given subscription ID or ref prefix.' -r
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l format -d 'Output format: table, tsv, or json [default: table].' -r -f -a "table\t'Aligned table for terminals'
tsv\t'Tab-separated values for scripts'
json\t'Pretty JSON'"
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l enabled-only -d 'Show only enabled configs.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l active-only -d 'Show only the active config.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l deleted -d 'Show only soft-deleted configs.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -l all -d 'Include soft-deleted configs in results.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from configs" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l kind -d 'Filter by source kind: url (remote subscription link), file (local file path), or raw-text (inline text).' -r -f -a "url\t'Remote subscription URL (https://...)'
file\t'Local file path on disk'
raw-text\t'Inline raw subscription text'"
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l format -d 'Output format: table, tsv, or json [default: table].' -r -f -a "table\t'Aligned table for terminals'
tsv\t'Tab-separated values for scripts'
json\t'Pretty JSON'"
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from subscriptions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "configs" -d 'List stored nodes/configs.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "subscriptions" -d 'List stored subscriptions.'
complete -c xrat -n "__fish_xrat_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -f -a "config" -d 'Show details for a config.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -f -a "subscription" -d 'Show details for a subscription.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and not __fish_seen_subcommand_from config subscription help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -l json -d 'Print the result as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from config" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -l json -d 'Print the result as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from subscription" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from help" -f -a "config" -d 'Show details for a config.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from help" -f -a "subscription" -d 'Show details for a subscription.'
complete -c xrat -n "__fish_xrat_using_subcommand show; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand enable" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand enable" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand enable" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand enable" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand enable" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand enable" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand enable" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand enable" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand disable" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disable" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disable" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disable" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disable" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disable" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand disable" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand disable" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -f -a "config" -d 'Soft delete a config (use --hard to delete permanently).'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -f -a "subscription" -d 'Delete a subscription and all of its configs.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and not __fish_seen_subcommand_from config subscription help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -l hard -d 'Permanently delete the config.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from config" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -l yes -d 'Skip the confirmation prompt.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from subscription" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from help" -f -a "config" -d 'Soft delete a config (use --hard to delete permanently).'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from help" -f -a "subscription" -d 'Delete a subscription and all of its configs.'
complete -c xrat -n "__fish_xrat_using_subcommand delete; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand restore" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand restore" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand restore" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand restore" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand restore" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand restore" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand restore" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand restore" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand purge" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand purge" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand purge" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand purge" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand purge" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand purge" -l yes -d 'Skip the confirmation prompt.'
complete -c xrat -n "__fish_xrat_using_subcommand purge" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand purge" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand purge" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l subscription -d 'Filter: only configs from the given subscription ID or ref prefix.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l test-url -d 'Override the URL used for real-delay (HTTP round-trip) checks.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l download-url -d 'Override the URL used for download speed checks.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l upload-url -d 'Enable upload speed stage and set the HTTP POST target URL.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l icmp-timeout -d 'Override ICMP timeout in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l tcp-timeout -d 'Override TCP connect timeout in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l real-delay-timeout -d 'Override real-delay HTTP request timeout in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l download-timeout -d 'Override download speed request timeout in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l upload-timeout -d 'Override upload speed request timeout in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l concurrency -d 'Bulk-test concurrency. 0 = auto-detect.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l format -d 'Output format for bulk results [default: table].' -r -f -a "table\t'Aligned table for terminals (default, human-readable)'
tsv\t'Tab-separated values (script-friendly)'
csv\t'Comma-separated values (spreadsheet compatible)'
json\t'JSON output (machine-parseable)'"
complete -c xrat -n "__fish_xrat_using_subcommand test" -l output -d 'Write bulk results to a file instead of stdout.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand test" -l sort-by -d 'Sort order for bulk results [default: status].' -r -f -a "status\t'Sort by test result status (alive first, then by failure reason)'
icmp\t'Sort by ICMP latency (lowest first)'
real-delay\t'Sort by real-delay latency (lowest first)'
download-speed\t'Sort by download throughput (highest first)'
protocol\t'Sort by protocol type alphabetically'
address\t'Sort by server address alphabetically'"
complete -c xrat -n "__fish_xrat_using_subcommand test" -l ping-interval -d 'Interval between ping-loop iterations in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l country -d 'Filter latest-run summary by endpoint country ISO code (e.g. US, DE).' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l asn -d 'Filter latest-run summary by ASN (case-insensitive substring match).' -r
complete -c xrat -n "__fish_xrat_using_subcommand test" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand test" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand test" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand test" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand test" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand test" -l enabled-only -d 'Filter: only enabled configs.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l active-only -d 'Filter: only the active config.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l skip-icmp -d 'Skip the ICMP ping stage.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l skip-tcp -d 'Skip the TCP connectivity stage.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l skip-real-delay -d 'Skip the real-delay (HTTP round-trip) stage.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l skip-download -d 'Skip the download speed stage.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l skip-upload -d 'Skip the upload speed stage (disabled by default).'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l no-progress -d 'Hide the animated progress bar.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l ping -d 'Continuously ping one config until Ctrl+C, printing a live summary.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -l latest-run-summary -d 'Print a summary of the latest persisted test run and exit.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l ips -d 'Comma-separated IPs to scan, e.g. 1.1.1.1,8.8.8.8.' -r
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l file -d 'Read newline-separated IPs from a file.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l port -d 'Target TCP port.' -r
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l timeout -d 'TCP connect timeout in milliseconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l history -d 'Print the latest N persisted scan results and exit (skips scanning).' -r
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l format -d 'Output format for --history: table, tsv, or json [default: table].' -r -f -a "table\t'Aligned table for terminals'
tsv\t'Tab-separated values for scripts'
json\t'Pretty JSON'"
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand scan" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand scan" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand scan" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand scan" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand connect" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand connect" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand connect" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand connect" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand connect" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand connect" -l json -d 'Print the result as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand connect" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand connect" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand connect" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -l json -d 'Print the result as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand disconnect" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand status" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand status" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand status" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand status" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand status" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand status" -l json -d 'Print the status as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand status" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand status" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand status" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -s n -l lines -d 'Number of recent entries to show before following [default: 200].' -r
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l source -d 'Which log feeds to include: all, app, daemon, xray, or singbox [default: all].' -r -f -a "all\t'App events + engine logs + daemon log'
app\t'Structured app/runtime events only'
daemon\t'Daemon process log file only'
xray\t'xray-core engine logs for the active/last session'
singbox\t'sing-box engine logs for the active/last session'"
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l level -d 'Only show events at or above this level (applies to app/event entries).' -r -f -a "info\t''
warn\t''
error\t''"
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l format -d 'Output format for the event stream: table, tsv, or json [default: table].' -r -f -a "table\t'Aligned table for terminals'
tsv\t'Tab-separated values for scripts'
json\t'Pretty JSON'"
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -s f -l follow -d 'Stream new log entries as they arrive instead of exiting.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -f -a "clear" -d 'Permanently delete persisted app events from the database.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and not __fish_seen_subcommand_from clear help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -l yes -d 'Skip the confirmation prompt.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from clear" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from help" -f -a "clear" -d 'Permanently delete persisted app events from the database.'
complete -c xrat -n "__fish_xrat_using_subcommand logs; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "start" -d 'Start the long-lived XRAT daemon process.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "run-server" -d 'Internal: run the daemon IPC server loop.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "status" -d 'Show daemon IPC reachability and protocol information.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "stop" -d 'Request daemon shutdown via local IPC.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "restart" -d 'Restart the daemon, reloading config.toml and the runtime session.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "install" -d 'Install xrat-daemon.service as a systemd user service.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "uninstall" -d 'Remove the installed xrat-daemon.service systemd user service.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and not __fish_seen_subcommand_from start run-server status stop restart install uninstall help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from run-server" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from restart" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l start -d 'Start the daemon immediately after enabling'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l dry-run -d 'Print the generated service unit without writing files'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l with-api -d 'Install the API server service alongside the daemon'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -l tun -d 'Configure the systemd service override for TUN capture (disables NoNewPrivileges)'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -l dry-run -d 'Print actions without executing them'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "start" -d 'Start the long-lived XRAT daemon process.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "run-server" -d 'Internal: run the daemon IPC server loop.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "status" -d 'Show daemon IPC reachability and protocol information.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "stop" -d 'Request daemon shutdown via local IPC.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "restart" -d 'Restart the daemon, reloading config.toml and the runtime session.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "install" -d 'Install xrat-daemon.service as a systemd user service.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "uninstall" -d 'Remove the installed xrat-daemon.service systemd user service.'
complete -c xrat -n "__fish_xrat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -f -a "migrate" -d 'Apply any pending database migrations and report the result.'
complete -c xrat -n "__fish_xrat_using_subcommand db; and not __fish_seen_subcommand_from migrate help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from migrate" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from help" -f -a "migrate" -d 'Apply any pending database migrations and report the result.'
complete -c xrat -n "__fish_xrat_using_subcommand db; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -f -a "enable" -d 'Enable automatic proxy rotation on a fixed schedule. State is volatile and resets to config defaults on daemon restart.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -f -a "disable" -d 'Disable automatic proxy rotation. State is volatile and resets to config defaults on daemon restart.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -f -a "status" -d 'Show the current proxy rotation status.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -f -a "now" -d 'Trigger an immediate manual rotation.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and not __fish_seen_subcommand_from enable disable status now help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from enable" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from disable" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -l json -d 'Print rotation status as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l config-id -d 'Force rotation to a specific enabled config ID or ref prefix.' -r
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -l refresh -d 'Refresh URL-backed subscriptions before selecting a candidate.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from now" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from help" -f -a "enable" -d 'Enable automatic proxy rotation on a fixed schedule. State is volatile and resets to config defaults on daemon restart.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from help" -f -a "disable" -d 'Disable automatic proxy rotation. State is volatile and resets to config defaults on daemon restart.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from help" -f -a "status" -d 'Show the current proxy rotation status.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from help" -f -a "now" -d 'Trigger an immediate manual rotation.'
complete -c xrat -n "__fish_xrat_using_subcommand rotate; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -f -a "info" -d 'Show active local proxy endpoints.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -f -a "pac" -d 'Print or locate the Proxy Auto-Config (PAC) file.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -f -a "shell" -d 'Print shell commands to proxy the current terminal session.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -f -a "desktop" -d 'Manage Linux desktop environment proxy settings.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and not __fish_seen_subcommand_from info pac shell desktop help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -l json -d 'Print proxy information as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from info" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -f -a "url" -d 'Print the PAC URL served by the API server.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -f -a "print" -d 'Print the generated PAC file for the active runtime.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from pac" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -f -a "enable" -d 'Print commands that point the current shell at xrat endpoints.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -f -a "disable" -d 'Print commands that unset the proxy environment variables.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -f -a "toggle" -d 'Toggle shell proxy variables, preserving previous values.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -f -a "status" -d 'Report whether the current shell points at active xrat endpoints.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from shell" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -f -a "enable" -d 'Point the Linux desktop proxy settings at xrat endpoints.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -f -a "disable" -d 'Reset the Linux desktop proxy settings to none.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -f -a "status" -d 'Show the current Linux desktop proxy settings.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -f -a "toggle" -d 'Toggle the Linux desktop proxy settings.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from desktop" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from help" -f -a "info" -d 'Show active local proxy endpoints.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from help" -f -a "pac" -d 'Print or locate the Proxy Auto-Config (PAC) file.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from help" -f -a "shell" -d 'Print shell commands to proxy the current terminal session.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from help" -f -a "desktop" -d 'Manage Linux desktop environment proxy settings.'
complete -c xrat -n "__fish_xrat_using_subcommand proxy; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l host -d 'Override HTTP API bind host.' -r
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l port -d 'Override HTTP API bind port.' -r
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand serve" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand serve" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand serve" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand serve" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tui" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tui" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tui" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tui" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tui" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tui" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand tui" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand tui" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -f -a "enable" -d 'Enable TUN capture in the config; restart the daemon and reconnect to apply.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -f -a "disable" -d 'Disable TUN capture in the config; restart the daemon and reconnect to apply.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -f -a "status" -d 'Report TUN readiness: engine, interface, and file capabilities.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -f -a "setup" -d 'Grant CAP_NET_ADMIN/CAP_NET_RAW to the files TUN needs via setcap.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and not __fish_seen_subcommand_from enable disable status setup help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from enable" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from disable" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -l json -d 'Print the result as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -l dry-run -d 'Print the setcap command without running it.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from setup" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from help" -f -a "enable" -d 'Enable TUN capture in the config; restart the daemon and reconnect to apply.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from help" -f -a "disable" -d 'Disable TUN capture in the config; restart the daemon and reconnect to apply.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from help" -f -a "status" -d 'Report TUN readiness: engine, interface, and file capabilities.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from help" -f -a "setup" -d 'Grant CAP_NET_ADMIN/CAP_NET_RAW to the files TUN needs via setcap.'
complete -c xrat -n "__fish_xrat_using_subcommand tun; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand update" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand update" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand update" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand update" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand update" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand update" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand update" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand update" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l file -d 'Read config links (one per line) from a local file.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l engine -d 'Proxy engine used to generate runtime config [default: auto].' -r -f -a "auto\t'Auto-detect: uses sing-box for hysteria2, xray for everything else'
xray\t'Always use Xray / Xray-core to generate the config'
sing-box\t'Always use sing-box to generate the config'"
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l stdin -d 'Read config links (one per line) from stdin.'
complete -c xrat -n "__fish_xrat_using_subcommand parse" -l json -d 'Print the generated runtime JSON config for the parsed node.'
complete -c xrat -n "__fish_xrat_using_subcommand parse" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand parse" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand parse" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand validate" -l format -d 'Output format for the validation result.' -r -f -a "human\t'Human-readable output'
json\t'Machine-readable JSON output'"
complete -c xrat -n "__fish_xrat_using_subcommand validate" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand validate" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand validate" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand validate" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand validate" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand validate" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand validate" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand validate" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l path -d 'Source directory to build from when --source is set.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l version -d 'Download a specific release tag instead of the latest.' -r
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l timeout -d 'HTTP request timeout in seconds for release downloads.' -r
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l source -d 'Build and install from source instead of downloading a release.'
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -l force -d 'Reinstall even when already on the requested version.'
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand upgrade" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand version" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand version" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand version" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand version" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand version" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand version" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand version" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand version" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "download" -d 'Download one or more GeoLite2 MMDB editions.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "update" -d 'Refresh all supported GeoLite2 MMDB editions.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "lookup" -d 'Look up a single IP through the configured GeoIP backend.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "backend" -d 'Print the active GeoIP backend configuration.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "path" -d 'Print the resolved MMDB directory.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "status" -d 'Show MMDB presence and size for each supported edition.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and not __fish_seen_subcommand_from download update lookup backend path status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l edition -d 'Edition to download. Repeatable: GeoLite2-Country|GeoLite2-City|GeoLite2-ASN or country|city|asn.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l output -d 'Override the MMDB target directory for this command.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l url -d 'Override the download URL template. Use {edition} as a placeholder.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l timeout -d 'Override the HTTP request timeout in seconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l all -d 'Download all supported editions.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l force -d 'Re-download even when the destination file already exists.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -l quiet -d 'Suppress progress bar output.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from download" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l output -d 'Override the MMDB target directory for this command.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l url -d 'Override the download URL template. Use {edition} as a placeholder.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l timeout -d 'Override the HTTP request timeout in seconds.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -l quiet -d 'Suppress progress bar output.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l backend -d 'Override backend for this invocation: mmdb, ipwhois, ip-api.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l no-cache -d 'Bypass the configured in-memory cache for this invocation.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -l json -d 'Print the lookup result as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from lookup" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l backend -d 'Override backend for this invocation: mmdb, ipwhois, ip-api.' -r
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l no-cache -d 'Describe the backend chain without cache wrapping.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -l json -d 'Print the backend configuration as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from backend" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -l output -d 'Override the MMDB target directory for this command.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from path" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l output -d 'Override the MMDB target directory for this command.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l strict -d 'Exit non-zero when any supported edition is missing.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -l json -d 'Print status as JSON.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "download" -d 'Download one or more GeoLite2 MMDB editions.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "update" -d 'Refresh all supported GeoLite2 MMDB editions.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "lookup" -d 'Look up a single IP through the configured GeoIP backend.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "backend" -d 'Print the active GeoIP backend configuration.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "path" -d 'Print the resolved MMDB directory.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "status" -d 'Show MMDB presence and size for each supported edition.'
complete -c xrat -n "__fish_xrat_using_subcommand mmdb; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -l output -d 'Directory to write generated man pages into' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand manpage" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand completions" -l database -d 'SQLite database path. Falls back to config.toml [database.sqlite].path, XRAT_PATH/db.sqlite, or ~/.config/xrat/db.sqlite.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand completions" -l config -d 'Config file path. Falls back to XRAT_PATH/config.toml or ~/.config/xrat/config.toml.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand completions" -l xray -d 'Xray binary path. Falls back to config.toml [paths].xray or \'xray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand completions" -l v2ray -d 'V2Ray binary path. Falls back to config.toml [paths].v2ray or \'v2ray\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand completions" -l sing-box -d 'sing-box binary path. Falls back to config.toml [paths].sing_box or \'sing-box\' in PATH.' -r -F
complete -c xrat -n "__fish_xrat_using_subcommand completions" -s v -l verbose -d 'Increase log verbosity. Repeat for more: -v = info, -vv = debug, -vvv = trace.'
complete -c xrat -n "__fish_xrat_using_subcommand completions" -s q -l quiet -d 'Suppress all output except errors. Ignored if RUST_LOG is set.'
complete -c xrat -n "__fish_xrat_using_subcommand completions" -s h -l help -d 'Print help'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "init" -d 'Initialize config directory, config file, and database.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "setup" -d 'Run post-install setup: proxy cores, init, daemon, completions, man pages, and desktop integration.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "install" -d 'Install Xray, V2Ray, or sing-box from its upstream release repository.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "import" -d 'Import a subscription URL, file, or raw text into SQLite.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "add" -d 'Add a single config URI directly to SQLite.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "list" -d 'List stored configs or subscriptions.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "show" -d 'Show details for a config or subscription.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "enable" -d 'Enable a config.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "disable" -d 'Disable a config.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "delete" -d 'Delete a config (soft/hard) or a subscription with its configs.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "restore" -d 'Restore a soft-deleted config.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "purge" -d 'Permanently delete all soft-deleted configs.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "test" -d 'Test connectivity and latency for stored configs.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "scan" -d 'Scan candidate IPs for TCP reachability and persist results.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "connect" -d 'Start a managed proxy runtime for a stored config.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "disconnect" -d 'Stop the active managed proxy runtime.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "status" -d 'Show the managed proxy runtime status.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "logs" -d 'Show app events plus xray-core / sing-box engine logs.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "daemon" -d 'Run or control the XRAT daemon supervisor process.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "db" -d 'Inspect and maintain the XRAT database.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "rotate" -d 'Control automatic proxy rotation scheduling via the daemon.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "proxy" -d 'Local proxy endpoints and host/session integration helpers.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "serve" -d 'Start the local Axum HTTP API server.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "tui" -d 'Start the interactive terminal UI.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "tun" -d 'Prepare and inspect system privileges for managed TUN capture.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "update" -d 'Refresh stored subscriptions.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "parse" -d 'Parse and validate config links without persisting.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "validate" -d 'Validate an XRAT config.toml file.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "upgrade" -d 'Self-upgrade xrat from the latest release or by building from source.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "version" -d 'Print the xrat version.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "mmdb" -d 'Inspect and manage GeoLite2 MMDB assets.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "manpage" -d 'Generate man pages for xrat and all subcommands.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "completions" -d 'Generate shell completion scripts for xrat.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and not __fish_seen_subcommand_from init setup install import add list show enable disable delete restore purge test scan connect disconnect status logs daemon db rotate proxy serve tui tun update parse validate upgrade version mmdb manpage completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "configs" -d 'List stored nodes/configs.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "subscriptions" -d 'List stored subscriptions.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from show" -f -a "config" -d 'Show details for a config.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from show" -f -a "subscription" -d 'Show details for a subscription.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from delete" -f -a "config" -d 'Soft delete a config (use --hard to delete permanently).'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from delete" -f -a "subscription" -d 'Delete a subscription and all of its configs.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from logs" -f -a "clear" -d 'Permanently delete persisted app events from the database.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "start" -d 'Start the long-lived XRAT daemon process.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "run-server" -d 'Internal: run the daemon IPC server loop.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "status" -d 'Show daemon IPC reachability and protocol information.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "stop" -d 'Request daemon shutdown via local IPC.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "restart" -d 'Restart the daemon, reloading config.toml and the runtime session.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "install" -d 'Install xrat-daemon.service as a systemd user service.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "uninstall" -d 'Remove the installed xrat-daemon.service systemd user service.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from db" -f -a "migrate" -d 'Apply any pending database migrations and report the result.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from rotate" -f -a "enable" -d 'Enable automatic proxy rotation on a fixed schedule. State is volatile and resets to config defaults on daemon restart.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from rotate" -f -a "disable" -d 'Disable automatic proxy rotation. State is volatile and resets to config defaults on daemon restart.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from rotate" -f -a "status" -d 'Show the current proxy rotation status.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from rotate" -f -a "now" -d 'Trigger an immediate manual rotation.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from proxy" -f -a "info" -d 'Show active local proxy endpoints.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from proxy" -f -a "pac" -d 'Print or locate the Proxy Auto-Config (PAC) file.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from proxy" -f -a "shell" -d 'Print shell commands to proxy the current terminal session.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from proxy" -f -a "desktop" -d 'Manage Linux desktop environment proxy settings.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from tun" -f -a "enable" -d 'Enable TUN capture in the config; restart the daemon and reconnect to apply.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from tun" -f -a "disable" -d 'Disable TUN capture in the config; restart the daemon and reconnect to apply.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from tun" -f -a "status" -d 'Report TUN readiness: engine, interface, and file capabilities.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from tun" -f -a "setup" -d 'Grant CAP_NET_ADMIN/CAP_NET_RAW to the files TUN needs via setcap.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from mmdb" -f -a "download" -d 'Download one or more GeoLite2 MMDB editions.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from mmdb" -f -a "update" -d 'Refresh all supported GeoLite2 MMDB editions.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from mmdb" -f -a "lookup" -d 'Look up a single IP through the configured GeoIP backend.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from mmdb" -f -a "backend" -d 'Print the active GeoIP backend configuration.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from mmdb" -f -a "path" -d 'Print the resolved MMDB directory.'
complete -c xrat -n "__fish_xrat_using_subcommand help; and __fish_seen_subcommand_from mmdb" -f -a "status" -d 'Show MMDB presence and size for each supported edition.'
