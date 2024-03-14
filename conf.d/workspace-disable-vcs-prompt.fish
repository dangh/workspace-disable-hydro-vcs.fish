status is-interactive || exit

function _workspace_disable_hydro_vcs -v PWD -v _workspace_root -d 'disable hydro git prompt when inside git workspace'
    set -q _hydro_git || return
    set -q hydro_ignored_git_paths || set -g hydro_ignored_git_paths
    set -q _workspace_root[1] || return
    set -l pwd (pwd -P)
    for git_root in $hydro_ignored_git_paths
        if string match -q "$git_root*" $pwd
            return
        end
    end
    string match -q -r "^(?<git_root>"(string escape --style=regex $_workspace_root/.ws/)"[^/]+)" -- $pwd
    set -a hydro_ignored_git_paths $git_root
end
