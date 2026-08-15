let
  stringLength = builtins.stringLength;
  substring = builtins.substring;

  romaji_map_base = {
    a = "あ"; i = "い"; u = "う"; e = "え"; o = "お";
    xa = "ぁ"; xi = "ぃ"; xu = "ぅ"; xe = "ぇ"; xo = "ぉ";
    ka = "か"; ki = "き"; ku = "く"; ke = "け"; ko = "こ";
    ga = "が"; gi = "ぎ"; gu = "ぐ"; ge = "げ"; go = "ご";
    sa = "さ"; si = "し"; su = "す"; se = "せ"; so = "そ";
    za = "ざ"; zi = "じ"; zu = "ず"; ze = "ぜ"; zo = "ぞ";
    ta = "た"; ti = "ち"; tu = "つ"; xtu = "っ"; te = "て"; to = "と";
    da = "だ"; di = "ぢ"; du = "づ"; de = "で"; "do" = "ど";
    na = "な"; ni = "に"; nu = "ぬ"; ne = "ね"; no = "の";
    ha = "は"; hi = "ひ"; hu = "ふ"; he = "へ"; ho = "ほ";
    ba = "ば"; bi = "び"; bu = "ぶ"; be = "べ"; bo = "ぼ";
    pa = "ぱ"; pi = "ぴ"; pu = "ぷ"; pe = "ぺ"; po = "ぽ";
    fa = "ふぁ"; fi = "ふぃ"; fu = "ふ"; fe = "ふぇ"; fo = "ふぉ";
    va = "ゔぁ"; vi = "ゔぃ"; vu = "ゔ"; ve = "ゔぇ"; vo = "ゔぉ";
    ma = "ま"; mi = "み"; mu = "む"; me = "め"; mo = "も";
    ya = "や"; yu = "ゆ"; yo = "よ";
    xya = "ゃ"; xyu = "ゅ"; xyo = "ょ";
    ra = "ら"; ri = "り"; ru = "る"; re = "れ"; ro = "ろ";
    wa = "わ"; wi = "うぃ"; we = "うぇ"; wo = "を";
    nn = "ん";
  };

  youon_map = builtins.listToAttrs (
    builtins.concatLists (
      builtins.map (
        k:
        let
          v = romaji_map_base.${k};
          c = substring 0 1 k;
          last = substring 1 1 k;
        in
        if stringLength k == 2 && last == "i" then
          [
            {
              name = "${c}ya";
              value = "${v}ゃ";
            }
            {
              name = "${c}yu";
              value = "${v}ゅ";
            }
            {
              name = "${c}ye";
              value = "${v}ぇ";
            }
            {
              name = "${c}yo";
              value = "${v}ょ";
            }
          ]
        else if stringLength k == 2 && last == "e" then
          [
            {
              name = "${c}yi";
              value = "${v}ぃ";
            }
          ]
        else
          [ ]
      ) (builtins.attrNames romaji_map_base)
    )
  );

  specials = {
    "," = [ "、" "" ];
    "." = [ "。" "" ];
  };
in
romaji_map_base // youon_map // specials
