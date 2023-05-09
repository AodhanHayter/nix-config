{ lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
    };

    enableSyntaxHighlighting = true;
    enableCompletion = true;

    profileExtra = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export PAGER="less"
      export GPG_TTY=$(tty)
      export NIX_CONFIG_PATH="$HOME/nix-config/"
      export PASSWORD_STORE_DIR="$HOME/.password-store"

      # allow homebrew packages to be run
      export PATH="$PATH:/opt/homebrew/bin"

      # pyenv stuff
      export PYENV_ROOT="$HOME/.pyenv"
      if command -v pyenv 1>/dev/null 2>&1; then
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
      fi

      if [ $(uname) = "Darwin" ]
      then
        export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
      fi
    '';

    prezto = {
      enable = true;

      caseSensitive = false;

      editor = {
        dotExpansion = true;
        keymap = "vi";
      };

      syntaxHighlighting = {
        styles = {
          alias = "fg=blue";
          builtin = "fg=blue";
          command = "fg=blue";
          function = "fg=blue";
          precommand = "fg=cyan";
          commandseparator = "fg=green";
        };
      };

      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "syntax-highlighting"
        "history-substring-search"
        "git"
      ];
    };

    initExtra = ''
      function tm() {
        [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
        if [ $1 ]; then
           tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
        fi
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
      }

      function pg() {
        if [ $1 ]; then
          PGSERVICE=$1 /opt/homebrew/Cellar/pgcli/3.5.0/bin/pgcli
        else
          echo 'A valid service name is required for this function'
        fi
      }

      [ -n "$(command -v fnm)" ] && eval "$(fnm env --use-on-cd)"

      function aws_login() {
        saml2aws login --session-duration 43200 --username "ahayter@kyruus.com" --duo-mfa-option="Duo Push" --skip-prompt --force --role="arn:aws:iam::206670668379:role/kyruusone-engineer"
      }
    '';

    plugins = [
      {
        name = "zsh-async";
        file = "async.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mafredri";
          repo = "zsh-async";
          rev = "v1.8.5";
          sha256 = "sha256-mpXT3Hoz0ptVOgFMBCuJa0EPkqP4wZLvr81+1uHDlCc=";
        };
      }
      {
        name = "pure";
        file = "pure.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "v1.20.1";
          sha256 = "sha256-iuLi0o++e0PqK81AKWfIbCV0CTIxq2Oki6U2oEYsr68=";
        };
      }
    ];
  };
}
