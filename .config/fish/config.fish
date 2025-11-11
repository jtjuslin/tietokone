if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - | source
end

set -g fish_greeting

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/jarkko/.pyenv/versions/miniforge3-23.3.1-1/bin/conda
    eval /home/jarkko/.pyenv/versions/miniforge3-23.3.1-1/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<

abbr --add hxc hx ~/.config
