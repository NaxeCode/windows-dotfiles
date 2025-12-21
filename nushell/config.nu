# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# See `help config nu` for more options

# Auto-Complete Plugin "carapace"
source ~/.cache/carapace/init.nu

# Starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Zoxide
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
source ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# -- NuShell config
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.completions.algorithm = "fuzzy"

# -- Neovim as the default NuShell editor
$env.EDITOR = "nvim"

# -- Vi Mode Cursor Shapes
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

# -- Theme (Tokyo Night Storm)
$env.config.color_config = {
    separator: "#3b4261"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#7aa2f7" attr: "b" }
    empty: "#565f89"
    bool: "#ff9e64"
    int: "#e0af68"
    float: "#e0af68"
    filesize: "#9ece6a"
    duration: "#9ece6a"
    date: "#7dcfff"
    range: "#bb9af7"
    string: "#c0caf5"
    nothing: "#565f89"
    binary: "#7aa2f7"
    cellpath: "#7dcfff"
    row_index: { fg: "#565f89" attr: "b" }
    record: "#c0caf5"
    list: "#c0caf5"
    block: "#c0caf5"
    hints: "#565f89"
    search_result: { fg: "#1f2335" bg: "#ff9e64" }
    shape_and: { fg: "#f7768e" attr: "b" }
    shape_binary: { fg: "#f7768e" attr: "b" }
    shape_block: { fg: "#7aa2f7" attr: "b" }
    shape_bool: "#ff9e64"
    shape_closure: "#7dcfff"
    shape_custom: "#9ece6a"
    shape_datetime: "#7dcfff"
    shape_directory: "#7aa2f7"
    shape_external: "#7aa2f7"
    shape_externalarg: "#c0caf5"
    shape_external_resolved: "#9ece6a"
    shape_filepath: "#7aa2f7"
    shape_flag: "#bb9af7"
    shape_float: "#e0af68"
    shape_garbage: { fg: "#1f2335" bg: "#f7768e" attr: "b" }
    shape_globpattern: "#7dcfff"
    shape_int: "#e0af68"
    shape_internalcall: "#7dcfff"
    shape_keyword: "#f7768e"
    shape_list: "#7aa2f7"
    shape_literal: "#e0af68"
    shape_match_pattern: "#bb9af7"
    shape_matching_brackets: { attr: "b" }
    shape_nothing: "#565f89"
    shape_operator: "#bb9af7"
    shape_or: { fg: "#f7768e" attr: "b" }
    shape_pipe: { fg: "#f7768e" attr: "b" }
    shape_range: "#bb9af7"
    shape_record: "#7aa2f7"
    shape_redirection: { fg: "#f7768e" attr: "b" }
    shape_signature: "#7dcfff"
    shape_string: "#9ece6a"
    shape_string_interpolation: "#7dcfff"
    shape_table: "#7aa2f7"
    shape_variable: "#c0caf5"
    shape_vardecl: "#c0caf5"
    shape_raw_string: "#9ece6a"
    shape_regex: "#ff9e64"
    shape_brackets: "#565f89"
    foreground: "#c0caf5"
    background: "#24283b"
    cursor: "#c0caf5"
}

# ===== DEVELOPMENT ENVIRONMENT ALIASES =====

# Navigation aliases
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..

# Git shortcuts
alias g = git status -sb
alias ga = git add
alias gs = git switch
alias gsc = git switch -C
alias gc = git commit -m
alias cd = z

# Legacy aliases (updated to new structure)
alias wrk = cd 'C:\Dev\Active\Work-Main'
alias gm = cd 'C:\Dev\Games'

# Quick directory listings
alias ll-active = ls 'C:\Dev\Active\' | sort-by modified | reverse
alias ll-sandbox = ls 'C:\Dev\Sandbox\' | sort-by modified | reverse
alias ll-archive = ls 'C:\Dev\Archive\' | sort-by modified | reverse
alias ll-learning = ls 'C:\Dev\Learning\' | sort-by modified | reverse
alias ll-games = ls 'C:\Dev\Games\' | sort-by modified | reverse
alias ll-tools = ls 'C:\Dev\Tools\'
alias ll-resources = ls 'C:\Dev\Resources\'

# Development shortcuts (using def instead of alias for source command)
def edit-config [] {
    nvim $nu.config-path
}

def edit-env [] {
    nvim $nu.env-path
}

# Tool shortcuts
def godot [...args] {
    ^'C:\Dev\Tools\Godot\Godot_v4.4.1-stable_mono_win64.exe' ...$args
}

def helix [...args] {
    ^'C:\Dev\Tools\helix\hx.exe' ...$args
}

# ===== CUSTOM COMMANDS =====

# Utilities
def mkcd [path: string] {
    mkdir $path
    cd $path
}

def croot [] {
    let git_root = (do -i { ^git rev-parse --show-toplevel } | default "" | str trim)
    if ($git_root | is-empty) {
        print "Not in a git repo"
    } else {
        cd $git_root
    }
}

def dirinfo [] {
    let entries = (ls)
    let dir_count = ($entries | where type == "dir" | length)
    let file_count = ($entries | where type == "file" | length)
    let git_root = (do -i { ^git rev-parse --show-toplevel } | default "" | str trim)

    print $"Path: ($env.PWD)"
    print $"Items: ($entries | length) dirs: ($dir_count), files: ($file_count)"
    if ($git_root | is-empty) {
        print "Git: (none)"
    } else {
        let git_branch = (do -i { ^git rev-parse --abbrev-ref HEAD } | default "" | str trim)
        print $"Git: ($git_branch)"
    }
}

# Project management commands
def new-project [name: string] {
    mkdir $'C:\Dev\Active\($name)'
    cd $'C:\Dev\Active\($name)'
    print $"Created new project: ($name)"
}

def new-learning [name: string] {
    mkdir $'C:\Dev\Learning\($name)'
    cd $'C:\Dev\Learning\($name)'
    print $"Created new learning project: ($name)"
}

def new-game [name: string] {
    mkdir $'C:\Dev\Games\($name)'
    cd $'C:\Dev\Games\($name)'
    print $"Created new game project: ($name)"
}

# Git clone helpers
def clone-explore [repo: string] {
    cd 'C:\Dev\Sandbox'
    git clone $repo
    print $"Cloned ($repo) to Sandbox for exploration"
}

def clone-active [repo: string] {
    cd 'C:\Dev\Active'
    git clone $repo
    print $"Cloned ($repo) to Active projects"
}

def clone-learning [repo: string] {
    cd 'C:\Dev\Learning'
    git clone $repo
    print $"Cloned ($repo) to Learning projects"
}

# Project management
def archive-project [name: string] {
    let project_path = $'C:\Dev\Active\($name)'
    let archive_path = $'C:\Dev\Archive\($name)'
    
    if ($project_path | path exists) {
        mv $project_path $archive_path
        print $"Archived project: ($name)"
    } else {
        print $"Project ($name) not found in Active directory"
    }
}

def activate-project [name: string] {
    let archive_path = $'C:\Dev\Archive\($name)'
    let active_path = $'C:\Dev\Active\($name)'
    
    if ($archive_path | path exists) {
        mv $archive_path $active_path
        print $"Activated project: ($name)"
    } else {
        print $"Project ($name) not found in Archive directory"
    }
}

# Project search and navigation
def find-project [search_term: string] {
    print "=== Searching for projects containing: ($search_term) ==="
    print "Active:"
    ls 'C:\Dev\Active\' | where name =~ $search_term | select name modified
    print "Games:"
    ls 'C:\Dev\Games\' | where name =~ $search_term | select name modified
    print "Learning:"
    ls 'C:\Dev\Learning\' | where name =~ $search_term | select name modified
    print "Archive:"
    ls 'C:\Dev\Archive\' | where name =~ $search_term | select name modified
}

def goto-project [search_term: string] {
    let active_matches = (ls 'C:\Dev\Active\' | where name =~ $search_term)
    let games_matches = (ls 'C:\Dev\Games\' | where name =~ $search_term)
    let learning_matches = (ls 'C:\Dev\Learning\' | where name =~ $search_term)
    let archive_matches = (ls 'C:\Dev\Archive\' | where name =~ $search_term)
    
    let all_matches = (
        ($active_matches | each { |it| $'C:\Dev\Active\($it.name | path basename)' }) ++
        ($games_matches | each { |it| $'C:\Dev\Games\($it.name | path basename)' }) ++
        ($learning_matches | each { |it| $'C:\Dev\Learning\($it.name | path basename)' }) ++
        ($archive_matches | each { |it| $'C:\Dev\Archive\($it.name | path basename)' })
    )
    
    if ($all_matches | length) == 1 {
        cd ($all_matches | first)
        print $"Navigated to: ($all_matches | first)"
    } else if ($all_matches | length) > 1 {
        print "Multiple matches found:"
        $all_matches | each { |match| print $"  ($match)" }
    } else {
        print $"No projects found matching: ($search_term)"
    }
}

# Cleanup helpers
def clean-sandbox [days: int = 30] {
    cd 'C:\Dev\Sandbox'
    let cutoff_date = ((date now) - ($days * 1day))
    let old_repos = (ls | where modified < $cutoff_date)
    
    if ($old_repos | length) > 0 {
        print $"Found ($old_repos | length) repositories older than ($days) days:"
        $old_repos | select name modified
        print "Run 'clean-sandbox-force' to actually delete them"
    } else {
        print $"No repositories older than ($days) days found"
    }
}

def clean-sandbox-force [days: int = 30] {
    cd 'C:\Dev\Sandbox'
    let cutoff_date = ((date now) - ($days * 1day))
    let old_repos = (ls | where modified < $cutoff_date)
    
    $old_repos | each { |repo|
        print $"Removing old repository: ($repo.name)"
        rm -rf $repo.name
    }
}

# Development overview
def dev-overview [] {
    print "=== Development Environment Overview ==="
    print $"Active Projects: (ls 'C:\Dev\Active\' | length)"
    print $"Sandbox Repos: (ls 'C:\Dev\Sandbox\' | length)" 
    print $"Archived Projects: (ls 'C:\Dev\Archive\' | length)"
    print $"Learning Projects: (ls 'C:\Dev\Learning\' | length)"
    print $"Game Projects: (ls 'C:\Dev\Games\' | length)"
    print ""
    print "=== Recent Activity (Active Projects) ==="
    ls 'C:\Dev\Active\' | sort-by modified | reverse | first 5 | select name modified
    print ""
    print "=== Sandbox Status ==="
    if (ls 'C:\Dev\Sandbox\' | length) > 0 {
        ls 'C:\Dev\Sandbox\' | sort-by modified | reverse | first 3 | select name modified
    } else {
        print "No repositories in sandbox"
    }
}

def dev-stats [] {
    let total_active = (ls 'C:\Dev\Active\' | length)
    let total_games = (ls 'C:\Dev\Games\' | length)
    let total_learning = (ls 'C:\Dev\Learning\' | length)
    let total_archived = (ls 'C:\Dev\Archive\' | length)
    let total_sandbox = (ls 'C:\Dev\Sandbox\' | length)
    let total_projects = ($total_active + $total_games + $total_learning + $total_archived)
    
    print "=== Development Statistics ==="
    print $"Total Projects: ($total_projects)"
    print $"  - Active: ($total_active)"
    print $"  - Games: ($total_games)"
    print $"  - Learning: ($total_learning)"
    print $"  - Archived: ($total_archived)"
    print $"Sandbox Repos: ($total_sandbox)"
}

# Yazi aliases and functions
alias y = yazi
alias fm = yazi

# Function to cd to the directory Yazi last visited
def yy [] {
    let tmp = $"($env.TEMP)/yazi-cwd-(random uuid)"
    yazi --cwd-file $tmp
    if ($tmp | path exists) {
        let cwd = (open $tmp | str trim)
        if ($cwd != $env.PWD) and ($cwd | path exists) {
            cd $cwd
        }
        rm $tmp
    }
}

# Quick access to browse dev directories
alias dev-fm = yazi 'C:\Dev\Active\'
alias games-fm = yazi 'C:\Dev\Games\'
$env.YAZI_FILE_ONE = $"(scoop prefix git)\\usr\\bin\\file.exe"
