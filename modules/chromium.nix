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
      "cpedeojecpbkcomgcolphimkjdnikbck" # Auto Clicker
      "mfmpnnhnknadgoafpindapobelgkblbk" # Cat-In-Tab
      "clldacgmdnnanihiibdgemajcfkmfhia" # Color Picker for Chrome
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "ponfpcnoihfmfllpaingbgckeeldkhle" # Enhancer for YouTube
      "godiecgffnchndlihlpaajjcplehddca" # GhostText
      "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # Google オフライン ドキュメント
      "neebplgakaahbhdphmkckjjcegoiijjo" # Keepa
      "ckkdlimhmcjmikdlpkmbgfkaikojcbjk" # Markdown Viewer
      "ioijepjbllchodiajdakejdbjmdgggoj" # PLaMo Translate
      "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
      "jplgfhpmjnbigmhklmmbgecoobifkmpa" # Proton VPN
      "gmloihcgbhbonllenincdakeijmikcne" # QR Scanner
      "ldgfbffkinooeloadekpmfoklnobpien" # Raindrop.io
      "fmkadmapgofadopljbjfkapdkoienihi" # React Developer Tools
      "pnjaodmkngahhkoihejjehlcdlnohgmp" # RSS Feed Reader
      "fjnbnpbmkenffdnngjfgmeleoegfcffe" # Stylish
      "pncfbmialoiaghdehhbnbhkkgmjanfhe" # uBlacklist
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "gabfmnliflodkdafenbcpjdlppllnemd" # 画像を JPG/PNG/WebP として保存
    ];
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "ExtensionSettings" = {
        # Proton Pass
        "ghmbeldphafepmbegfdlkpapadhbakde" = {
          "toolbar_pin" = "force_pinned";
        };
        # Dark Reader
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" = {
          "toolbar_pin" = "force_pinned";
        };
        # Color Picker for Chrome
        "clldacgmdnnanihiibdgemajcfkmfhia" = {
          "toolbar_pin" = "force_pinned";
        };
        # PLaMo Translate
        "ioijepjbllchodiajdakejdbjmdgggoj" = {
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
