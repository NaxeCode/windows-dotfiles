# env.nu
#
# Installed by:
# version = "0.102.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
if (which carapace | is-empty) == false {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    try {
        carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")
    } catch {
        # Ignore carapace init failures to avoid blocking shell startup.
    }
}

# Zoxide (generate init file before config loads)
mkdir ($nu.data-dir | path join "vendor/autoload")
let zoxide_init = ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
if (which zoxide | is-empty) == false {
    try {
        zoxide init nushell | save -f $zoxide_init
    } catch {
        # Ignore zoxide init failures to avoid blocking shell startup.
    }
} else {
    # Ensure the file exists so config.nu can source it safely.
    "" | save -f $zoxide_init
}
let home_dir = ($env.HOME? | default $env.USERPROFILE?)
if $home_dir != null {
    $env.PATH = ($env.PATH | prepend $"($home_dir)/.cargo/bin")
}
if $home_dir != null and $nu.os-info.name == "linux" {
    let local_bin = $"($home_dir)/.local/bin"
    if ($local_bin | path exists) {
        $env.PATH = ($env.PATH | prepend $local_bin)
    }
}

# Homebrew paths (Linux and macOS), added only if present.
let brew_paths = [
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
]
for p in $brew_paths {
    if ($p | path exists) {
        $env.PATH = ($env.PATH | prepend $p)
    }
}
