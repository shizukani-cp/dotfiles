{
  config,
  pkgs,
  plasma-manager,
  ...
}:

{
  imports = [
    plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;
    shortcuts = {
      "kwin" = {
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Walk Through Windows Alternative" = [ ];
        "Overview" = "Meta+Tab";
      };
    };
    panels = [
      {
        location = "left";
        lengthMode = "fill";
        height = 33;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake";
              };
            };
          }
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:brave-browser.desktop"
                  "applications:foot.desktop"
                ];
              };
            };
          }
          # "org.kde.plasma.weather"
          # "org.kde.plasma.systemmonitor.diskusage"
          # "org.kde.plasma.systemmonitor.diskquota"
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                showDate = true;
                dateFormat = "custom";
                customDateFormat = "MM/dd";
              };
            };
          }
        ];
      }
    ];
    kwin.virtualDesktops.number = 2;
    configFile = {
      "kdeglobals" = {
        "KScreen" = {
          "ScaleFactor" = 1.25;
        };
      };
    };
  };
}
