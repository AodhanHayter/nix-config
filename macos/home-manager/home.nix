# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
    ../../home-manager/common.nix
    ../../home-manager/git.nix
    ../../home-manager/tmux.nix
    ../../home-manager/nvim.nix
    ../../home-manager/alacritty.nix
    ../../home-manager/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "ahayter";
    homeDirectory = "/Users/ahayter";
  };

 programs.zsh.sessionVariables = {
    DOCKER_HOST = "unix:///Users/ahayter/.colima/docker.sock";
  };

  home.shellAliases = {
    hm = "home-manager switch -b backup --flake $NIX_CONFIG_PATH";
    rebuild = "darwin-rebuild switch --flake $NIX_CONFIG_PATH";
    nvm = "fnm";
  };

  home.packages = with pkgs; [
    awscli
    circleci-cli
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.CoreServices
    elixir_ls
    fd
    fnm
    htop
    httpie
    jid
    jq
    karabiner-elements
    marksman
    mkcert
    nodePackages.bash-language-server
    nodePackages.diagnostic-languageserver
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.pyright
    nodePackages.typescript-language-server
    passExtensions.pass-update
    pgcli
    prettyping
    pwgen
    ripgrep
    rmtrash
    rnix-lsp
    saml2aws
    shellcheck
    shfmt
    ssm-session-manager-plugin
    sumneko-lua-language-server
    tealdeer
    terraform
    terraform-ls
    tree
  ];

  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyApplications =
      let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        baseDir="$HOME/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
