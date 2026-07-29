{ config, lib, pkgs, ... }:

let 
  cfg = config.devlive.features.devel-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ast-grep
      nil
      tree-sitter
    ]
    ++(if (config.devlive.features.desktop.type != null || config.devlive.host.system == "darwin") then [
        pkgs.dbeaver-bin
    ] else [ ]);

    programs.fd.enable = true;
    programs.fzf.enable = true;
    programs.neovim = {
      enable = true;
      sideloadInitLua = true;
    };
    programs.ripgrep.enable = true;

    devlive.programs.lazygit.enable = true;
    devlive.programs.vscode.enable = true;
    devlive.programs.zed-editor.enable = true;
  };
}
