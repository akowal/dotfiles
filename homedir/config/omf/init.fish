#!/usr/bin/env fish
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx theme_powerline_fonts (if test -z "$NOFANCY"; echo 'yes'; else; echo 'no'; end)
set -gx theme_nerd_fonts  (if test -z "$NOFANCY"; echo 'yes'; else; echo 'no'; end)
set -gx theme_newline_cursor yes
set -gx theme_display_k8s_context yes

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
alias ls exa
alias mkdir "mkdir -pv"

abbr lg "lazygit"
abbr gf "git fetch --prune"
abbr gfa "git fetch --all --prune"
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
abbr gdb "git branch --list --format='%(if:equals=[gone])%(upstream:track)%(then)%(refname)%(end)' | sed 's,^refs/heads/,,;/^\$/d' | xargs git branch -d"
abbr gb "git reset HEAD~1"

abbr ktx kubectx
abbr kns kubens
abbr ktl kubectl
abbr rm "rmtrash"
abbr ports "lsof -nP +c 15 | grep LISTEN"

set PATH $HOME/.cargo/bin  $PATH

function lst
    set -l level 2
    set -l dir .

    if test (count $argv) = 2
        set level $argv[1]
        set dir $argv[2]
    else if test (count $argv[1]) = 1
        set dir $argv[1]
    end

    exa --tree --level $level $dir
end

thefuck --alias | source

