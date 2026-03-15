{ ... }:
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
      "fonts.tabs.selected" = "16px 'Noto Sans CJK JP'";
      "fonts.tabs.unselected" = "16px 'Noto Sans CJK JP'";
      "tabs.favicons.show" = "always";
      "tabs.position" = "left";
      "tabs.title.format" = "{index} {audio}{host}";
      "tabs.width" = 80;
    };
    extraConfig = ''
      config.bind('ts', 'open -t https://translate.google.com/translate?sl=auto&tl=ja&u={url}')
      config.bind(';2', 'jseval document.querySelector("video").playbackRate = 2.0')
      config.bind(';1', 'jseval document.querySelector("video").playbackRate = 1.0')
      darkmode_disables = ( "https://discord.com/", )
      for s in darkmode_disables:
          config.set('colors.webpage.darkmode.enabled', False, s + "*")
      for i in range(1, 10):
          config.bind(f'<Ctrl-{i}>', f'tab-focus {i}')
    '';
  };
}
