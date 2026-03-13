{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(capslock_layer, f9)";
            muhenkan = "overload(muhenkan_layer, muhenkan)";
          };
          "capslock_layer:S" = {
            b = "backspace";
            n = "delete";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            o = "enter";
            u = "noop";

            w = "up";
            a = "left";
            s = "down";
            d = "right";
            e = "enter";
            q = "backspace";
            r = "delete";
          };
          "muhenkan_layer" = {
            y = "1";
            u = "2";
            i = "3";
            o = "4";
            p = "5";
            h = "6";
            j = "7";
            k = "8";
            l = "9";
            ";" = "0";
          };
        };
      };
    };
  };

}
