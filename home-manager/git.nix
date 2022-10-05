{ pkgs, lib, ... }: {
  programs.git = {
    enable = true;

    aliases = {
      sync = "!sh -c 'git fetch origin \"$0\":\"$0\"'";
      prune = "fetch --prune";
      undo = "reset --soft HEAD^";
      stash-all = "stash save --include-untracked";
      glog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      clean-remotes = "remote prune origin";
      clean-remotes-dry = "remote prune origin --dry-run";
      clean-locals = "!git branch -vv | rg 'origin/.+: gone]' | awk '{print $1}' | xargs git branch -d";
      clean-locals-dry = "!git branch -vv | rg 'origin/.+: gone]' | awk '{print $1}'";
    };

    diff-so-fancy = {
      enable = true;
    };

    ignores = [
      "*~"
      "*.swp"
      # linux stuff
      ".fuse_hidden*"
      ".directory"
      ".Trash-*"
      ".nfs*"
      # macos stuff
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "._*"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
      # gpg
      "secring.*"
      # development stuff
      "aodhanlocal"
    ];

    signing = {
      key = "3FBACD0B82D05567FC1BB765FD58CC579E91D1C5";
      signByDefault = true;
    };

    userEmail = "aodhan.hayter@gmail.com";
  };
}
