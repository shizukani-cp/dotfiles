{ config, pkgs, ... }:
let
  leader = "<Space>";
  color-palette = {
    bg = "#24283b";
    bg_dark = "#1f2335";
    bg_highlight = "#292e42";
    bg_popup = "#1f2335";
    bg_statusline = "#1f2335";
    bg_visual = "#3d59a1";
    black = "#1b1e2d";
    blue = "#7aa2f7";
    border_highlight = "#2ac3de";
    cyan = "#7dcfff";
    dark3 = "#545c7e";
    dark5 = "#737aa2";
    error = "#db4b4b";
    fg = "#c0caf5";
    fg_gutter = "#3b4261";
    green = "#9ece6a";
    green1 = "#73daca";
    info = "#0db9d7";
    magenta = "#bb9af7";
    orange = "#ff9e64";
    purple = "#9d7cd8";
    warning = "#e0af68";
    yellow = "#e0af68";
  };
in
{
  programs.qutebrowser = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "qutebrowser-wrapped";
      paths = [ (pkgs.qutebrowser.override { enableWideVine = true; }) ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/qutebrowser \
          --set QT_QPA_PLATFORM xcb
      '';
    };
    settings = {
      "auto_save.interval" = 1000;
      "auto_save.session" = true;
      "colors.completion.fg" = color-palette.fg;
      "colors.completion.odd.bg" = color-palette.bg_dark;
      "colors.completion.even.bg" = color-palette.bg;
      "colors.completion.category.fg" = color-palette.blue;
      "colors.completion.category.bg" = color-palette.bg_dark;
      "colors.completion.category.border.top" = color-palette.bg_dark;
      "colors.completion.category.border.bottom" = color-palette.bg_dark;
      "colors.completion.item.selected.fg" = color-palette.fg;
      "colors.completion.item.selected.bg" = color-palette.bg_visual;
      "colors.completion.item.selected.border.top" = color-palette.bg_visual;
      "colors.completion.item.selected.border.bottom" = color-palette.bg_visual;
      "colors.completion.item.selected.match.fg" = color-palette.orange;
      "colors.completion.match.fg" = color-palette.orange;
      "colors.completion.scrollbar.fg" = color-palette.fg_gutter;
      "colors.completion.scrollbar.bg" = color-palette.bg_dark;
      "colors.contextmenu.disabled.bg" = color-palette.bg_dark;
      "colors.contextmenu.disabled.fg" = color-palette.dark5;
      "colors.contextmenu.menu.bg" = color-palette.bg_popup;
      "colors.contextmenu.menu.fg" = color-palette.fg;
      "colors.contextmenu.selected.bg" = color-palette.bg_visual;
      "colors.contextmenu.selected.fg" = color-palette.fg;
      "colors.downloads.bar.bg" = color-palette.bg_statusline;
      "colors.downloads.start.fg" = color-palette.bg;
      "colors.downloads.start.bg" = color-palette.blue;
      "colors.downloads.stop.fg" = color-palette.bg;
      "colors.downloads.stop.bg" = color-palette.green;
      "colors.downloads.error.fg" = color-palette.error;
      "colors.hints.fg" = color-palette.bg;
      "colors.hints.bg" = color-palette.yellow;
      "colors.hints.match.fg" = color-palette.green;
      "colors.keyhint.fg" = color-palette.fg;
      "colors.keyhint.suffix.fg" = color-palette.yellow;
      "colors.keyhint.bg" = color-palette.bg_popup;
      "colors.messages.error.fg" = color-palette.error;
      "colors.messages.error.bg" = color-palette.bg;
      "colors.messages.error.border" = color-palette.error;
      "colors.messages.warning.fg" = color-palette.warning;
      "colors.messages.warning.bg" = color-palette.bg;
      "colors.messages.warning.border" = color-palette.warning;
      "colors.messages.info.fg" = color-palette.info;
      "colors.messages.info.bg" = color-palette.bg;
      "colors.messages.info.border" = color-palette.info;
      "colors.prompts.fg" = color-palette.fg;
      "colors.prompts.border" = color-palette.border_highlight;
      "colors.prompts.bg" = color-palette.bg_popup;
      "colors.prompts.selected.bg" = color-palette.bg_visual;
      "colors.prompts.selected.fg" = color-palette.fg;
      "colors.statusbar.normal.fg" = color-palette.blue;
      "colors.statusbar.normal.bg" = color-palette.bg_statusline;
      "colors.statusbar.insert.fg" = color-palette.green;
      "colors.statusbar.insert.bg" = color-palette.bg_highlight;
      "colors.statusbar.passthrough.fg" = color-palette.blue;
      "colors.statusbar.passthrough.bg" = color-palette.bg_highlight;
      "colors.statusbar.private.fg" = color-palette.purple;
      "colors.statusbar.private.bg" = color-palette.bg_highlight;
      "colors.statusbar.command.fg" = color-palette.fg;
      "colors.statusbar.command.bg" = color-palette.bg_statusline;
      "colors.statusbar.command.private.fg" = color-palette.purple;
      "colors.statusbar.command.private.bg" = color-palette.bg_highlight;
      "colors.statusbar.caret.fg" = color-palette.magenta;
      "colors.statusbar.caret.bg" = color-palette.bg_highlight;
      "colors.statusbar.caret.selection.fg" = color-palette.cyan;
      "colors.statusbar.caret.selection.bg" = color-palette.bg_highlight;
      "colors.statusbar.progress.bg" = color-palette.blue;
      "colors.statusbar.url.fg" = color-palette.fg;
      "colors.statusbar.url.error.fg" = color-palette.error;
      "colors.statusbar.url.hover.fg" = color-palette.cyan;
      "colors.statusbar.url.success.http.fg" = color-palette.orange;
      "colors.statusbar.url.success.https.fg" = color-palette.green1;
      "colors.statusbar.url.warn.fg" = color-palette.warning;
      "colors.tabs.bar.bg" = color-palette.black;
      "colors.tabs.indicator.start" = color-palette.blue;
      "colors.tabs.indicator.stop" = color-palette.green;
      "colors.tabs.indicator.error" = color-palette.error;
      "colors.tabs.odd.fg" = color-palette.dark3;
      "colors.tabs.odd.bg" = color-palette.bg_highlight;
      "colors.tabs.even.fg" = color-palette.dark3;
      "colors.tabs.even.bg" = color-palette.bg_highlight;
      "colors.tabs.pinned.even.bg" = color-palette.bg_highlight;
      "colors.tabs.pinned.even.fg" = color-palette.dark3;
      "colors.tabs.pinned.odd.bg" = color-palette.bg_highlight;
      "colors.tabs.pinned.odd.fg" = color-palette.dark3;
      "colors.tabs.pinned.selected.even.fg" = color-palette.bg;
      "colors.tabs.pinned.selected.even.bg" = color-palette.magenta;
      "colors.tabs.pinned.selected.odd.fg" = color-palette.bg;
      "colors.tabs.pinned.selected.odd.bg" = color-palette.magenta;
      "colors.tabs.selected.odd.fg" = color-palette.bg;
      "colors.tabs.selected.odd.bg" = color-palette.magenta;
      "colors.tabs.selected.even.fg" = color-palette.bg;
      "colors.tabs.selected.even.bg" = color-palette.magenta;
      "colors.tooltip.bg" = color-palette.bg_popup;
      "colors.tooltip.fg" = color-palette.fg;
      "colors.webpage.darkmode.algorithm" = "lightness-cielab";
      "colors.webpage.darkmode.enabled" = true;
      "colors.webpage.darkmode.policy.images" = "never";
      "colors.webpage.darkmode.threshold.background" = 205;
      "colors.webpage.darkmode.threshold.foreground" = 150;
      "colors.webpage.preferred_color_scheme" = "dark";
      "content.autoplay" = false;
      "content.blocking.enabled" = true;
      "content.blocking.method" = "adblock";
      "content.cookies.accept" = "all";
      "content.cookies.store" = true;
      "content.pdfjs" = true;
      "downloads.location.directory" = "${config.home.homeDirectory}/scratch";
      "fonts.tabs.selected" = "16px 'Noto Sans CJK JP'";
      "fonts.tabs.unselected" = "16px 'Noto Sans CJK JP'";
      "hints.chars" = "auoitnsr";
      "qt.args" = [ "disable-gpu" ];
      "session.lazy_restore" = true;
      "tabs.favicons.show" = "always";
      "tabs.new_position.related" = "last";
      "tabs.position" = "left";
      "tabs.title.format" = "{index} {audio}{host}";
      "tabs.width" = 80;
    };
    searchEngines = {
      "DEFAULT" = "https://duckduckgo.com/?q={}";
      "d" = "https://duckduckgo.com/?q={}";
      "g" = "https://github.com/{}";
      "gs" = "https://github.com/search?q={}";
      "go" = "https://www.google.com/search?q={}";
      "n" = "https://search.nixos.org/packages?query={}";
      "y" = "https://youtube.com{}";
    };
    extraConfig = ''
      config.bind('${leader}pt', 'open -t https://translate.google.com/translate?sl=auto&tl=ja&u={url}')
      config.bind('${leader}pd', 'config-cycle colors.webpage.darkmode.enabled')
      config.bind('${leader}p2', 'jseval document.querySelector("video").playbackRate = 2.0')
      config.bind('${leader}p1', 'jseval document.querySelector("video").playbackRate = 1.0')
      config.bind('${leader}${leader}', 'fake-key ${leader}')
      config.bind('<Shift-Down>', 'tab-next')
      config.bind('<Shift-Up>', 'tab-prev')
      darkmode_disables = ( "https://discord.com/", "http://localhost:3000/", "https://docs.google.com/", )
      for s in darkmode_disables:
          config.set('colors.webpage.darkmode.enabled', False, s + "*")
      for i in range(1, 10):
          config.bind(f'<Ctrl-{i}>', f'tab-focus {i}')

      import os
      local_script = os.path.expanduser('~/.config/qutebrowser/local_config.py')
      if os.path.exists(local_script):
          config.source(local_script)
    '';
  };
}
