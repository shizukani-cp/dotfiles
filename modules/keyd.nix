{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            # 左手上段
            q = "layer(function_layer)";
            w = "layer(symbols_layer)";
            e = "layer(shift_layer)";
            r = "layer(special_layer)";
            t = "layer(number_layer)";
            # 左手中段
            a = "a";
            s = "u";
            d = "o";
            f = "i";
            g = "e";
            # 左手下段
            z = "leftmeta";
            x = "leftcontrol";
            c = "layer(fn_layer)";
            v = "leftalt";

            apostrophe = "layer(shift_layer)";

            # 右手上段
            y = "b";
            u = "h";
            i = "k";
            o = "d";
            p = "c";
            # 右手中段
            h = "z";
            j = "t";
            k = "n";
            l = "s";
            semicolon = "r";
            # 右手下段
            b = "y";
            n = "l";
            m = "m";
            comma = "p";
            dot = "g";
            slash = "w";
          };
          "shift_layer:S" = { };
          "function_layer" = {
            # 中段
            j = "mute";
            k = "volumedown";
            l = "volumeup";
            semicolon = "henkan";
          };
          "fn_layer+function_layer" = {
            # 上段
            y = "f5";
            u = "f6";
            i = "f7";
            o = "f8";
            p = "f10";
            # 中段
            h = "f4";
            j = "f1";
            k = "f2";
            l = "f3";
            semicolon = "f9";
            # 下段
            n = "f11";
            m = "f12";
          };
          "symbols_layer" = {
            # 上段
            y = "apostrophe"; # '
            u = "equal"; # =
            i = "minus"; # -
            o = "S-minus"; # _
            p = "S-semicolon"; # :
            # 中段
            h = "semicolon"; # ;
            j = "dot"; # .
            k = "comma"; # ,
            l = "S-9"; # (
            semicolon = "S-0"; # )
            # 下段
            b = "["; # [
            n = "]"; # ]
            m = "`"; # `
            comma = "{"; # {
            dot = "}"; # }
            slash = "S-apostrophe"; # "
          };
          "symbols_layer+shift_layer" = {
            # 上段
            y = "|"; # |
            u = "!"; # !
            i = "slash"; # /
            o = "%"; # %
            p = "S-7"; # &
            # 中段
            h = "?"; # ?
            j = "#"; # #
            k = "S-equal"; # +
            l = "S-8"; # *
            semicolon = "$"; # $
            # 下段
            b = "<"; # <
            n = ">"; # >
            m = "`"; # `
            comma = "@"; # @
            dot = "backslash"; # \
            slash = "~"; # ~
          };
          "special_layer" = {
            # 上段
            u = "delete";
            i = "space";
            o = "enter";
            p = "escape";
            # 中段
            h = "backspace";
            j = "left";
            k = "down";
            l = "up";
            semicolon = "right";
            # 下段
            n = "C-f1"; # n,mに関してはVim側で受け取れるか検証
            m = "C-f2";
            slash = "tab";
          };
          "number_layer" = {
            # 上段(使わないアルファベット)
            y = "q";
            u = "f";
            i = "v";
            o = "x";
            p = "j";
            # 中段
            h = "9";
            j = "1";
            k = "0";
            l = "2";
            semicolon = "3";
            # 下段
            n = "8";
            m = "4";
            comma = "5";
            dot = "6";
            slash = "7";
          };
        };
      };
    };
  };
}
