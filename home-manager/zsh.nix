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

      [ -n "$(command -v fnm)" ] && eval "$(fnm env --use-on-cd)"
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
