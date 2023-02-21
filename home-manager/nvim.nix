{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig =
      ''
        lua << EOF
        ${lib.strings.fileContents ../dotfiles/nvim/lua/settings.lua}
        ${lib.strings.fileContents ../dotfiles/nvim/lua/maps.lua}
        ${lib.strings.fileContents ../dotfiles/nvim/lua/plugins-lazy.lua}
        EOF
      '';
  };
}
