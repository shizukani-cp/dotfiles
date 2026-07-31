{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.chromium.override {
      commandLineArgs = [
        "--enable-features=VerticalTabs"
      ];
    })
  ];
  programs.chromium = {
    enable = true;
    extensions = [
      "bhghoamapcdpbohphigoooaddinpkbai" # Authenticator
      "clldacgmdnnanihiibdgemajcfkmfhia" # Color Picker for Chrome
      "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # Google オフライン ドキュメント
      "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
      "jplgfhpmjnbigmhklmmbgecoobifkmpa" # Proton VPN
      "gmloihcgbhbonllenincdakeijmikcne" # QR Scanner
    ];
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "ExtensionSettings" = {
        # Proton Pass
        "ghmbeldphafepmbegfdlkpapadhbakde" = {
          "toolbar_pin" = "force_pinned";
        };
        # Color Picker for Chrome
        "clldacgmdnnanihiibdgemajcfkmfhia" = {
          "toolbar_pin" = "force_pinned";
        };
        # Authenticator
        "bhghoamapcdpbohphigoooaddinpkbai" = {
          "toolbar_pin" = "force_pinned";
        };
      };
      "VerticalTabsAllowed" = true;
    };
  };
}
