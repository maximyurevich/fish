set -U fish_greeting ""

fish_vi_key_bindings

set -Ux fish_lsp_diagnostic_disable_error_codes 2002 2003

set -x DOCKER_HOST "unix:///run/user/1000/docker.sock"
set -x VISUAL nvim
set -x EDITOR nvim
set -x PAGER "less -R"
set -x BAT_THEME ansi
set -x BROWSER /usr/bin/chromium

# wsl

set -Ux LIBVA_DRIVER_NAME d3d12

fish_add_path $HOME/.local/share/nvim/mason/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.npm/bin

# fzf

set -gx FZF_DEFAULT_OPTS "
--color=fg:#c0caf5,bg:#24283b,hl:#ff9e64
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# rye

set -ga fish_user_paths "$HOME/.rye/shims"
rye self completion -s fish >~/.config/fish/completions/rye.fish

# pyenv

set -gx PYENV_ROOT $HOME/.pyenv
set -g fish_user_paths $PYENV_ROOT/bin $fish_user_paths

pyenv init - fish | source

# mise

if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

# zoxide

zoxide init fish | source

# ssh

if not pgrep --full ssh-agent | string collect >/dev/null
  eval (ssh-agent -c)
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
