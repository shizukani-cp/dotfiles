{ config, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music/bgm";
    extraConfig = ''
      audio_output {
        type    "httpd"
        name    "My BGM Stream"
        encoder "opus"
        port    "8000"
        bind_address "127.0.0.1"
        bitrate "128000"
        format  "48000:16:2"
      }
    '';
  };
}
