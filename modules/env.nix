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
      kanatableData = import ../lib/kanatable.nix;

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
  vime-manager = pkgs.writeShellScriptBin "vime-manager" ''
    #!/usr/bin/env bash
    set -euo pipefail

    RUN_DIR="''${XDG_RUNTIME_DIR:-/tmp}"
    READY_PIPE="$RUN_DIR/nvim-vime-ready.pipe"

    cleanup() {
      rm -f "$READY_PIPE"
    }
    trap cleanup EXIT

    while true; do
      rm -f "$READY_PIPE"

      ${pkgs-unstable.neovim}/bin/nvim --listen "$READY_PIPE" --headless -c 'normal! i' &
      NVIM_PID=$!

      while [ ! -S "$READY_PIPE" ]; do
        sleep 0.05
      done

      while [ -S "$READY_PIPE" ]; do
        if ! kill -0 "$NVIM_PID" 2>/dev/null; then
          break
        fi
        sleep 0.1
      done
    done
  '';
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
  );
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
      ExecStart = "${pkgs.bash}/bin/bash ${vime-manager}/bin/vime-manager";
      Restart = "always";
    };
  };
}
