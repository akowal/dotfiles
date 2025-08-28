#!/usr/bin/env fish
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
#set -x JAVA_HOME (/usr/libexec/java_home)
set -gx GOPATH $HOME/go
# set -gx GOROOT /opt/homebrew/bin/go

set -gx theme_powerline_fonts (if test -z "$NOFANCY"; echo 'yes'; else; echo 'no'; end)
set -gx theme_nerd_fonts  (if test -z "$NOFANCY"; echo 'yes'; else; echo 'no'; end)
set -gx theme_newline_cursor yes
set -gx theme_display_k8s_context yes
set -gx theme_display_k8s_namespace yes

function colors
  set -l selected_scheme (ls -1 $HOME/.config/base16/scripts/base16-*.sh | fzf -1)
  if test -z "$selected_scheme"
    return
  end
  set -Ux base16_scheme $selected_scheme
  eval sh "$base16_scheme"
end

if status --is-interactive
  if test -n "$base16_scheme"
    eval sh "$base16_scheme"
  else
    eval sh "$HOME/.config/base16/scripts/base16-spacemacs.sh"
  end
end

set -gx EDITOR nvim
set -gx VISUAL nvim

alias vim nvim
alias ls eza
alias mkdir "mkdir -pv"

abbr gf "git fetch --prune --all"
abbr gfm "git fetch origin main:main"
abbr gs "git status --short"
abbr gl "git log --oneline"
abbr gp "git push"
abbr gpf "git push --force"
abbr gc "git commit"
abbr ga "git add"
abbr gr "git rebase"
abbr gd "git status -s | string sub -s4 | fzf -1 | xargs git diff"
abbr gco "git checkout"
abbr gcb "git checkout -b"
abbr grc "git rebase --continue"
abbr gra "git rebase --abort"
abbr gch "git cherry-pick"
abbr gst "git stash"
abbr gstp "git stash pop"
abbr gg "git grep"
abbr gwip "git add .; and git commit -m wip"
abbr gdba "git branch --list --format='%(if:equals=[gone])%(upstream:track)%(then)%(refname)%(end)' | sed 's,^refs/heads/,,;/^\$/d' | xargs git branch -d"
abbr gdb "git branch -l --format='%(refname:short)' | fzf -1 | xargs git branch -D"
abbr gb "git reset HEAD~1"

abbr k k9s
abbr ktx kubectx
abbr kns kubens
abbr ktl kubectl
abbr ports "lsof -nP +c 15 | grep LISTEN"

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/bin $PATH

function lst
    set -l level 2
    set -l dir .

    if test (count $argv) = 2
        set level $argv[1]
        set dir $argv[2]
    else if test (count $argv[1]) = 1
        set dir $argv[1]
    end

    eza --tree --level $level $dir
end

function spring-set-log-level
    if test (count $argv) -eq 0
        echo "Usage: set-log-level <url>"
        return 1
    end

    set url $argv[1]
    set loggers_url "$url/actuator/loggers"
    set log_levels TRACE DEBUG INFO WARN ERROR OFF
    set all_loggers (curl -s $loggers_url | jq -r '.loggers | keys | .[]' )
    set logger (printf "%s\n" $all_loggers | fzf)
    set level (printf "%s\n" $log_levels | fzf)

    if test -z "$logger" -o -z "$level"
        echo "Cancelled."
        return 1
    end

    set rq "{\"configuredLevel\":\"$level\"}"

    curl -X POST -H "Content-Type: application/json" -d $rq $loggers_url/$logger

    echo "Set log level of $logger to $level."
end

function fwd-db
    set K8S_CONTEXT (kubectl config get-contexts --no-headers -o name | fzf --prompt "K8s context: ")

    if test -z "$K8S_CONTEXT"
        echo "No context selected"
        return 1
    end

    set NAMESPACES_WITH_SERVICE (kubectl --context $K8S_CONTEXT get services --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name | grep "transaction" | awk '{print $1}' | uniq)

    if test -z "$NAMESPACES_WITH_SERVICE"
        echo "No namespaces found with the 'transaction' service!"
        return 1
    end

    set K8S_NAMESPACE (echo "$NAMESPACES_WITH_SERVICE" | tr ' ' '\n' | fzf --prompt "Namespace: ")

    if test -z "$K8S_NAMESPACE"
        echo "No namespace selected"
        return 1
    end

    set POD (kubectl --context $K8S_CONTEXT -n $K8S_NAMESPACE get pods -o custom-columns=:metadata.name | grep '^transaction' | head -n 1)

    if test -z "$POD"
        echo "No transaction svc pod found"
        return 1
    end

    echo "Port forwarding to $K8S_CONTEXT/$K8S_NAMESPACE/$POD"
    kubectl --context $K8S_CONTEXT -n $K8S_NAMESPACE port-forward $POD 5433:5432
end
