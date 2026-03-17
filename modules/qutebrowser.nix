{ ... }:
let
  leader = "<Space>";
in
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      "auto_save.session" = true;
      "colors.webpage.darkmode.enabled" = true;
      "colors.webpage.darkmode.policy.images" = "never";
      "content.autoplay" = false;
      "content.blocking.enabled" = true;
      "content.blocking.method" = "adblock";
      "content.cookies.accept" = "all";
      "content.cookies.store" = true;
      "content.pdfjs" = true;
      "fonts.tabs.selected" = "16px 'Noto Sans CJK JP'";
      "fonts.tabs.unselected" = "16px 'Noto Sans CJK JP'";
      "tabs.favicons.show" = "always";
      "tabs.position" = "left";
      "tabs.title.format" = "{index} {audio}{host}";
      "tabs.width" = 80;
    };
    extraConfig = ''
      config.bind('${leader}pt', 'open -t https://translate.google.com/translate?sl=auto&tl=ja&u={url}')
      config.bind('${leader}p2', 'jseval document.querySelector("video").playbackRate = 2.0')
      config.bind('${leader}p1', 'jseval document.querySelector("video").playbackRate = 1.0')
      config.bind('${leader}${leader}', 'fake-key ${leader}')
      darkmode_disables = ( "https://discord.com/", )
      for s in darkmode_disables:
          config.set('colors.webpage.darkmode.enabled', False, s + "*")
      for i in range(1, 10):
          config.bind(f'<Ctrl-{i}>', f'tab-focus {i}')
    '';
  };
}
