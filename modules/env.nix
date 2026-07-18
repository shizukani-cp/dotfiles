{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  huj8Table =
    pkgs.runCommand "huj8.lua"
      {
        buildInputs = with pkgs; [
          lua5_4
          luajit
        ];
      }
      ''
        lua ${../nvim/lua/data/huj8_gen.lua} > temp.lua
        luajit -b temp.lua $out
      '';
  compileNvim = true;
  compiledNvimConfig =
    if compileNvim then
      pkgs.runCommand "compiled-nvim-config"
        {
          nativeBuildInputs = [ pkgs.luajit ];
        }
        ''
          mkdir -p $out
          cp -r ${../nvim}/* $out/

          chmod -R +w $out

          mkdir -p $out/lua/data
          cp ${huj8Table} $out/lua/data/huj8.lua

          find $out -name "*.lua" -type f -exec echo "Compiling {}..." \; -exec luajit -b {} {} \;
        ''
    else
      pkgs.runCommand "uncompiled-nvim-config" { } ''
        mkdir -p $out
        cp -r ${../nvim}/* $out/
        chmod -R +w $out

        mkdir -p $out/lua/data
        cp ${huj8Table} $out/lua/data/huj8.lua
      '';
in
{
  home.username = "shizukani-cp";
  home.homeDirectory = "/home/shizukani-cp";
  home.stateVersion = "26.05";
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeLavender;
    name = "catppuccin-frappe-lavender-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  home.file = {
    ".gitconfig".source = ../.gitconfig;
    ".local/share/skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
  };
  xdg.enable = true;
  xdg.configFile = {
    "nvim" = {
      source = compiledNvimConfig;
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
  };
  home.sessionVariables = {
    DOTFILES_DIR = "${config.home.sessionVariables.PROJECTS_DIR}/dotfiles";
    EDITOR = "nvim";
    LANG = "ja_JP.UTF-8";
    LESSCHARSET = "utf-8";
    PATH = "$HOME/.local/bin:$PATH";
    PROJECTS_DIR = "${config.home.homeDirectory}/workspace/github.com/shizukani-cp";
    SCRATCH_DIR = "${config.home.homeDirectory}/scratch";
  };
  systemd.user.services.nvim-vime = {
    Unit = {
      Description = "Neovim VIME Server";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      Environment = [ "VIME=1" ];
      ExecStart = "${pkgs-unstable.neovim}/bin/nvim --listen %t/nvim-vime.pipe --headless";
      Restart = "always";
    };
  };
}
