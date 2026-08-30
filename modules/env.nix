{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  customKanatableFile = pkgs.writeText "kanatable.lua" (
    let
      kanatableData = import ../lib/kanatable.nix // {
        " " = "henkanFirst";
        "^" = "henkanPoint";
        ":" = "zenkaku";
        ";" = "katakana";
        "/" = "abbrev";
      };

      renderEntry =
        k: v:
        let
          escapedKey = builtins.replaceStrings [ "\\" ''"'' ] [ "\\\\" ''\"'' ] k;
        in
        if builtins.isList v then
          let
            v1 = builtins.replaceStrings [ "\\" ''"'' ] [ "\\\\" ''\"'' ] (builtins.elemAt v 0);
            v2 = builtins.replaceStrings [ "\\" ''"'' ] [ "\\\\" ''\"'' ] (builtins.elemAt v 1);
          in
          ''["${escapedKey}"] = {"${v1}", "${v2}"},''
        else
          let
            vStr = builtins.replaceStrings [ "\\" ''"'' ] [ "\\\\" ''\"'' ] v;
          in
          ''["${escapedKey}"] = "${vStr}",'';

      luaBody = builtins.concatStringsSep "\n" (lib.mapAttrsToList renderEntry kanatableData);

    in
    ''
      return {
      ${luaBody}
      }
    ''
  );
  compileNvim = false;
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
          cp ${customKanatableFile} $out/lua/data/kanatable.lua

          find $out -name "*.lua" -type f -exec echo "Compiling {}..." \; -exec luajit -b {} {} \;
        ''
    else
      pkgs.runCommand "uncompiled-nvim-config" { } ''
        mkdir -p $out
        cp -r ${../nvim}/* $out/
        chmod -R +w $out

        mkdir -p $out/lua/data
        cp ${customKanatableFile} $out/lua/data/kanatable.lua
      '';
  vime-manager = pkgs.writers.writePython3Bin "vime-manager" {
    libraries = [ ];
  } (builtins.readFile ../files/vime.py);
  skk-jisyo = builtins.listToAttrs (
    map
      (name: {
        name = "skk/SKK-JISYO.${name}";
        value = {
          source = "${pkgs.skkDictionaries.${lib.toLower name}}/share/skk/SKK-JISYO.${name}";
        };
      })
      [
        "L"
        "geo"
        "station"
      ]
  ) // {
      "skk/SKK-JISYO.maru-num" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Lttce/skk-maru-num/main/SKK-JISYO.maru-num";
          hash = "sha256-JRKMuG4WiVTXdXWynm6n6bGm4pt08bn07xp5AWA1F8w=";
        };
      };
    };
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
  xdg.enable = true;
  xdg.dataFile = skk-jisyo;
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
      Description = "Neovim VIME Pool Manager";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      Environment = [ "VIME=1" ];
      ExecStart = "${vime-manager}/bin/vime-manager";
      Restart = "always";
    };
  };
  services.network-manager-applet.enable = true;
}
